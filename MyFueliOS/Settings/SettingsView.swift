//
//  SettingsView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 21/3/21.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel = SettingsViewModel()
    var body: some View {
        VStack{
            selectFuelTypeView
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 16, trailing: 16))
        }
    }
    
    
    private var selectFuelTypeView: some View {
            ZStack{
                Color.white
                HStack{
                    Text("Fuel Type").font(.title3).opacity(0.6)
                    Spacer()
                  //  Text(viewModel.product.description).font(.title3)
                    Image(systemName: "chevron.right")
                }.padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
            }.frame( height: 60, alignment: .center)
            .cornerRadius(20)
       
        .onTapGesture {
            print("change fuel type tapped")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
