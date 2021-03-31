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
                Text("About Fuel Lens")
            }

            NavigationLink(destination: FuelWatchDataSourceView()) {
                Text("Fuel Watch Data source")
            }
        })
    }
    

    private var shareThisAppSection: some View {
        Section(header: Text("FAQ & Others"), content: {
            NavigationLink(destination: AboutView()) {
                Text("Why stations are not showing in my area?")
                //Answer, try to select the region manually, fuel lens tried to detect your location if you are outside of Perth region and make fuel request but there could be error and not load, so try manually. Also station might not be on fuelwatch database.
            }
            
            NavigationLink(destination: PrivacyView()) {
                Text("Privacy Policy")
            }

            NavigationLink(destination: DisclaimerView()) {
                Text("Disclaimer")
            }

            Text("Fuel Lens App version 1.0")

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
