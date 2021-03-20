//
//  MyFueliOSApp.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 28/2/21.
//

import SwiftUI

@main
struct MyFueliOSApp: App {
    
    init() {
        setupApperance()
    }
    
    var body: some Scene {
        
        WindowGroup {
            ContentView().accentColor(.SteamGold)
        }
    }
    
    private func setupApperance() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "SteamGold")!,
            NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 40)!]
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "SteamGold")!,
            NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 18)!]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([
                                                                NSAttributedString.Key.foregroundColor: UIColor(named: "SteamGold")!,
                                                                NSAttributedString.Key.font: UIFont(name: "FjallaOne-Regular", size: 16)!],
                                                            for: .normal)
        
        UIWindow.appearance().tintColor = UIColor(named: "SteamGold")
    }}
