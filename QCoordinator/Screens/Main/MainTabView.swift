//
//  MainTabView.swift
//  QCoordinator
//
//  Created by Quang on 15/10/25.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @State private var selectedTab: TabItem = .home

    var body: some View {
        TabView(selection: $selectedTab) {

            // Home
            NavigationStack(path: $appCoordinator.homeCoordinator.path) {
                appCoordinator.homeCoordinator.destination(for: .home).environmentObject(appCoordinator.appState)
            }
            .tabItem {
                Label(TabItem.home.title, systemImage: TabItem.home.icon)
            }
            .tag(TabItem.home)

            // Files
            NavigationStack(path: $appCoordinator.filesCoordinator.path) {
                appCoordinator.filesCoordinator.destination(for: .dashboard)
            }
            .tabItem {
                Label(TabItem.files.title, systemImage: TabItem.files.icon)
            }
            .tag(TabItem.files)

            // Profile
            NavigationStack(path: $appCoordinator.profileCoordinator.path) {
                appCoordinator.profileCoordinator.destination(for: .profile)
            }
            .tabItem {
                Label(TabItem.profile.title, systemImage: TabItem.profile.icon)
            }
            .tag(TabItem.profile)
        }
    }
}
