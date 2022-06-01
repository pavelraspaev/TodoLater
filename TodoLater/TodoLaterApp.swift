//
//  TodoLaterApp.swift
//  TodoLater
//
//  Created by Pavel Raspaev on 31.05.2022.
//

import SwiftUI

@main
struct TodoLaterApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .navigationViewStyle(.stack)
            .environmentObject(listViewModel)
        }
    }
}
