//
//  QCoordinatorApp.swift
//  QCoordinator
//
//  Created by Quang on 14/10/25.
//

import SwiftData
import SwiftUI

@main
struct QCoordinatorApp: App {
    @StateObject var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.locale, Locale(identifier: "vi"))
                .environmentObject(appCoordinator)
        }
    }
}
