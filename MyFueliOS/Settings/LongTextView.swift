//
// Created by Thinh Tran on 25/3/21.
//

import Foundation
import SwiftUI

struct LongTextView: View {
    var title: String
    var text: String
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16){
                    Text(title)
                        .font(.title).bold()
                    Text(text)
                        .font(.title3)
                    Spacer()
                }
                .padding()
            }
        }.navigationBarTitleDisplayMode(.inline)
    }

}

struct TermsView_Previews: PreviewProvider {
    static var previews: some View {
        LongTextView(title: "Why hello and how are you how are you",
                     text: "While substantial amount effort was made to ensure the data in Fuel Lens app is current and accurate,While substantial amount effort was made to ensure the data in Fuel Lens app is current and accurateWhile substantial amount effort was made to ensure the data in Fuel Lens app is current and accurate")
    }
}
