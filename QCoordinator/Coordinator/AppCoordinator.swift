//
//  AppCoordinator.swift
//  QCoordinator
//
//  Created by Quang on 14/10/25.
//

import Foundation
import SwiftUI

enum AppRoute: Hashable {
    case main
    case update
    case login
}

final class AppCoordinator: Coordinator {
    typealias Route = AppRoute
    @ObservedObject var appState = AppState.shared

    // MARK: coordinators
    lazy var homeCoordinator = HomeCoordinator()
    lazy var filesCoordinator = FilesCoordinator()
    lazy var profileCoordinator = ProfileCoordinator()

    func destination(for route: AppRoute) -> some View {
        switch route {
        case .main:
            return DestinationView(MainTabView())
        case .update:
            return DestinationView(UpdateView())
        case .login:
            return DestinationView(LoginView())
        }
    }
}
