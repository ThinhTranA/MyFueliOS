//
// Created by Thinh Tran on 25/3/21.
//

import Foundation
import SwiftUI

struct FuelWatchDataSourceView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Fuel watch data source").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("Real-time price data is sourced directly from Fuel Watch RSS feed")
                .font(.title3)
        
            Button(action: {
                //Open apple map
                let url = URL(string: "https://www.fuelwatch.wa.gov.au/")
                if let url = url {
                    UIApplication.shared.open(url)
                }
            }){
                Text("https://www.fuelwatch.wa.gov.au/") //Open web link
            }
            
            Text("""
The Department of Mines, Industry Regulation and Safety undergoes system maintenance every Wednesday from approximately 17:00-22:00 hours.
As a result, FuelWatch services may be unavailable during this time.
""")
            Spacer()
        }

    }

}

struct FuelWatchDataSourceView_Previews: PreviewProvider {
    static var previews: some View {
        FuelWatchDataSourceView()
    }
}
