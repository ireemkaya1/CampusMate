//
//  CampusMateApp 2.swift
//  CampusMate
//
//  Created by ASUS on 28.04.2026.
//


import SwiftUI

@main
struct CampusMateApp: App {
    @StateObject private var eventListVM = EventListViewModel()
    @StateObject private var favoritesVM = FavoritesViewModel()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(eventListVM)
                .environmentObject(favoritesVM)
                .onAppear {
                    NotificationManager.shared.requestPermission()
                }
        }
    }
}
