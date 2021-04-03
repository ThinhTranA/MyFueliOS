//
//  BuyMeACoffeeView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 3/4/21.
//

import SwiftUI

struct BuyMeACoffeeView: View {
    var body: some View {
        VStack (spacing: 32) {
            Text("Fuel Lens is free to use and always will be. However, if you find this app useful and want to buy me a coffee 🙏 below are the buttons. Anything donated will go directly to my ☕️ consumption.").font(.title3)
            
            if UserDefaults.standard.bool(forKey: "*ID of IAP Product*") {
                  Text("Purchased")
                      .foregroundColor(.green)
              }
            
            Button(action: {
                     
                  }, label: {
                  HStack(spacing: 10) {
                        Spacer()
                    Text("Small ☕️  $1.99").font(.title3)
                        Spacer()
                      }
                    .frame( height: 42, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.SteamGold)
                    .foregroundColor(.white)
                    .cornerRadius(22)
              })  .shadow(color: Color.black.opacity(0.3),
                          radius: 5, x: 3,y: -3)
            
            Button(action: {
                     
                  }, label: {
                  HStack(spacing: 10) {
                        Spacer()
                    Text("Large").font(.title3)
                    Text("☕️").font(.title)
                    Text("$3.90").font(.title3)
                        Spacer()
                      }
                    .frame( height: 42, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.SteamGold)
                    .foregroundColor(.white)
                    .cornerRadius(22)
              })   .shadow(color: Color.black.opacity(0.3),
                           radius: 5, x: 3,y: -3)

            Button(action: {
                     
                  }, label: {
                  HStack(spacing: 10) {
                        Spacer()
                    Text("☕️☕️☕️☕️☕️").font(.title)
                    Text("$19.50").font(.title3)
                        Spacer()
                      }
                    .frame( height: 42, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.SteamGold)
                    .foregroundColor(.white)
                    .cornerRadius(22)
              })  .shadow(color: Color.black.opacity(0.3),
                          radius: 5, x: 3,y: -3)
            
            Spacer()
        }
        .padding()
    
    }
}

struct BuyMeACoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        BuyMeACoffeeView()
    }
}
