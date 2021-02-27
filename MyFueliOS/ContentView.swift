//
//  ContentView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/2/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StationsView()
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Stations")
                    }
                }.tag(0)
            
            MapView()
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
