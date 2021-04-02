//
//  ContentView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/2/21.
//

import SwiftUI
import FontAwesome_swift

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    VStack {
                        Image(systemName: "square.grid.2x2.fill")
                        Text("Dashboard")
                    }
                }.tag(0)
            StationsMapView()
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }.tag(1)
            StationListView()
                .tabItem {
                    VStack {
                        Image(uiImage: UIImage.fontAwesomeIcon(name: .gasPump, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)))
                        Text("Stations")
                    }
                }.tag(2)
            
            FavouriteView()
                .tabItem {
                    VStack {
                        Image(uiImage: UIImage.fontAwesomeIcon(name: .star, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)))
                        Text("Favourites")
                    }
                }.tag(3)
            
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
                }.tag(4)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
