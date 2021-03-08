//
//  StationDetailView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 3/3/21.
//

import SwiftUI

struct StationDetailView: View {
    var body: some View {
        VStack{
            StationDetailMap()
            Spacer()
            StationDetailPrice()
            StationDetailOptions()
        }
    }
}

struct StationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailView()
    }
}
