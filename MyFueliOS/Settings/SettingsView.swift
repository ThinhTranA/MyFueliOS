//
//  SettingsView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 21/3/21.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel = SettingsViewModel()
    @State var selectedProduct = Product.UnleadedPetrol
    @State var selectedRegion = RegionCode.Perth
    @State var selectedDate: Int = 0
    let datesText = ["Today", "Tomorrow"]
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    var body: some View {
        NavigationView {
            Form {
                fuelsSection
                resetSection
                shareThisAppSection
            }.navigationBarTitle("Settings")
        }.onAppear{
            viewModel.loadSettings()
        }


    }

    private var fuelsSection: some View {
        Section(header: Text("Fuel settings"), content: {
            Picker(selection: $viewModel.product,
                    label: Text("Fuel Type"),
                    content: {
                        ForEach(Product.allCases, id: \.self) { p in
                            Text(p.description)
                        }
                    })

            Picker(selection: $viewModel.region,
                    label: Text("Region"),
                    content: {
                        ForEach(RegionCode.allCases, id: \.self) { rc in
                            Text(rc.text)
                        }
                    })
        })
    }

    private var resetSection: some View {
        Section(header: Text("About"), content: {
            NavigationLink(destination: AboutView()) {
                Text("About Fuel Lens v\(appVersion ?? "")")
            }

            NavigationLink(destination: FuelWatchDataSourceView()) {
                Text("Fuel Watch Data source")
            }
        })
    }
    

    let disclaimerText = "While I makes every efforts to ensure the data in Fuel Lens app is current and accurate, however, you acknowledge there are may be errors and will not rely on the application as a guaranteed source of information. You agree to use it only as a guide."
    let fqa1 = "Why stations are not showing in my area?"
    let fqa2 = "Why a favourite station is not showing for some fuel type in favourites list?"
    
    private var shareThisAppSection: some View {
        Section(header: Text("FAQs & Others"), content: {
            NavigationLink(destination: LongTextView(title: fqa1, text: "Ans: Fuel lens will try to detect your suburb given location permission when you are outside of Perth region and make corresponding request to Fuel Watch API. However, there are some instances where it failed to detect your suburb. In that case, please try manually select your region on the Fuel Setting sections.")) {
                Text(fqa1)
            }
            
            NavigationLink(destination: LongTextView(title: fqa2, text: "Ans: Not every fuel type are available at the station. Fuel Lens app will not display the station in favourite list if the selected fuel type is not available for that specific station on favourite screen.")) {
                Text(fqa2)
                //Answer, not every fuel type are alvaible at the station.
            }

            NavigationLink(destination: LongTextView(title: "Disclaimer", text: disclaimerText)) {
                Text("Disclaimer")
            }

            Button(action: {
                print("todo: share this app")
            }) {
                Text("Share this App")
            }
        })
    }


}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
