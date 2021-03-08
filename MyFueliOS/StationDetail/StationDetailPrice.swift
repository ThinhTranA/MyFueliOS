//
//  StationDetailPrice.swift
//  MyFueliOS
//
//  Created by Hung Tran on 8/3/21.
//

import SwiftUI

struct StationDetailPrice: View {
    var body: some View {
        VStack(){
            HStack{
                Text("Type")
                Spacer()
                Text("Price")
            }
            .padding()
        }
    }
}

struct StationDetailPrice_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailPrice()
    }
}
