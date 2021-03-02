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
            StationListView()
                .tabItem {
                    VStack {
                        Image(uiImage: UIImage.fontAwesomeIcon(name: .gasPump, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)))
                        Text("Stations")
                    }
                }.tag(0)
            
            MapView()
                .tabItem {
                    VStack {
                        Image(systemName: "map")
                        Text("Map")
                    }
                }.tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
