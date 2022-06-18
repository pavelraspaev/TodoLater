//
//  TodoLaterApp.swift
//  TodoLater
//
//  Created by Pavel Raspaev on 31.05.2022.
//

import SwiftUI

@main
struct TodoLaterApp: App {
    
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(homeViewModel)
                .statusBar(hidden: true)
        }
    }
}
