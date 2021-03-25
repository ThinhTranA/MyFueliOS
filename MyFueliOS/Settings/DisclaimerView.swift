//
// Created by Thinh Tran on 25/3/21.
//

import Foundation
import SwiftUI

struct DisclaimerView: View {

    var body: some View {
        NavigationView {
            VStack{
                Text("""
                     While I makes every efforts to ensure the data in Fuel Lens app is current and accurate, however, you acknowledge there are may be errors
                      and will not rely on the application as a guaranteed source of information. You agree to use it only as a guide.
                     """)
            }.navigationTitle("Disclaimer")
        }


    }

}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        DisclaimerView()
    }
}
