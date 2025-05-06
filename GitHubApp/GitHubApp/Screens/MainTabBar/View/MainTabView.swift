//
//  MainTabView.swift
//  GitHubApp
//
//  Created by Ihor Ilin on 16.04.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                        
            NotificationsView()
                .tabItem {
                    Label("Notifications", systemImage: "house")
                }

            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "house")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "house")
                }
        }
    }
}

#Preview {
    MainTabView()
}
