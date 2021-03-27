//
// Created by Thinh Tran on 27/3/21.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack{
            Color(.systemBackground).opacity(0.8).ignoresSafeArea()
            VStack(spacing: 24){
                ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.SteamGold))
                    .scaleEffect(2)
                Text("Loading...").font(.FHACondFrenchNC(size: 24))
            }
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
