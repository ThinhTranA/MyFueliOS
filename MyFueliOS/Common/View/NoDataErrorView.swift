//
//  ErrorView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 2/4/21.
//

import SwiftUI

struct NoDataErrorView: View {
    var body: some View {
        
        VStack (spacing: 16){
            Text("Something went wrong").font(.title2)
            Text("☹️📲🐌").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("Failed to load data. Please try again later")
                .multilineTextAlignment(.center)
                .font(.headline)
            if(Date().getWeekDay() == WeekDay.wednesday){
                Text("""
    The Department of Mines, Industry Regulation and Safety undergoes system maintenance every Wednesday from approximately 17:00-22:00 hours.
    As a result, FuelWatch services may be unavailable during this time.
    """)            }
        }
        .padding()

    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataErrorView()
    }
}
