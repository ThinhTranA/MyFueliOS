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
    @State var selectedDate: Int = 0
    let datesText = ["Today", "Tomorrow"]

    var body: some View {
        NavigationView {
            Form {
                fuelsSection
                resetSection
                shareThisAppSection
            }.navigationBarTitle("Settings")
        }


    }

    private var fuelsSection: some View {
        Section(header: Text("Fuel settings"), content: {
            Picker(selection: $selectedProduct,
                    label: Text("Fuel Type"),
                    content: {
                        ForEach(Product.allCases, id: \.self) { p in
                            Text(p.description)
                        }
                    })

            Picker(selection: $selectedDate,
                    label: Text("Date of Displayed Prices"),
                    content: {
                        ForEach(0..<self.datesText.count) {
                            Text(self.datesText[$0]).tag($0)
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
        Section(header: Text("Others"), content: {
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
