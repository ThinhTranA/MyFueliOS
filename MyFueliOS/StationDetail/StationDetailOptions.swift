//
//  StationDetailOptions.swift
//  MyFueliOS
//
//  Created by Hung Tran on 8/3/21.
//

import SwiftUI

struct StationDetailOptions: View {
    var body: some View {
        VStack(){
            
            Button(action: {}){
                HStack{
                    Text("Add to Favorite")
                    Spacer()
                    Label("",systemImage: "star")
                }
                .padding()
            }
            
            Button(action:{}){
                HStack{
                    Text("Get directions")
                    Spacer()
                    Label("",systemImage: "car")
                    
                }
                .padding()
            }


        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}

struct StationDetailOptions_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailOptions()
    }
}
