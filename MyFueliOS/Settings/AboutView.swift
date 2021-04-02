//
// Created by Thinh Tran on 25/3/21.
//

import Foundation
import SwiftUI
import MessageUI


struct AboutView: View {
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var isShowingMailDisableAlert = false

    var body: some View {
        VStack (alignment: .leading, spacing: 32){
            VStack (alignment: .leading, spacing: 16){
                Text("Thanks for using Fuel Lens").font(.title)
                Text("If you run into any issues or have a suggestion, please send me an email at myfuellens@gmail.com by using the email support button below.").font(.title3)
            }
     
            Button(action: {
                if MFMailComposeViewController.canSendMail(){
                    self.isShowingMailView.toggle()
                } else {
                    self.isShowingMailDisableAlert.toggle()
                }
             
            }, label: {
            HStack(spacing: 10) {
                  Spacer()
                  Text("Email support")
                  Image(systemName: "envelope")
                      .resizable()
                      .frame(width: 28, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                  Spacer()
                }
              .frame( height: 42, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
              .background(Color.blue)
              .foregroundColor(.white)
              .cornerRadius(22)
        })  .disabled(!MFMailComposeViewController.canSendMail())
            .alert(isPresented: $isShowingMailDisableAlert) {
                       Alert(title: Text("Fuel Lens"), message: Text("Unable to send email from this device"), dismissButton: .default(Text("Ok")))
                   }
            .sheet(isPresented: $isShowingMailView) {
                      MailView(result: $result) { composer in
                          composer.setSubject("Fuel Lens enquiry")
                          composer.setToRecipients(["myfuellens@gmail.com"])
                      }
                  }

            VStack (alignment: .leading, spacing: 16) {
                Text("Made possible by").font(.title)
                Text("Fuel Watch RSS").font(.title3)
                Text("SwiftUI").font(.title3)
                Text("SwiftXMLParser").font(.title3)
            }
      
       // Text("please email for any feedback, feature request or other enquiry: myfuellens@gmail.com")
        
        Spacer()
       }
    
       .padding()
       .navigationTitle("About")

    }

}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
