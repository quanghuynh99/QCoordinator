//
//  MainView.swift
//  QCoordinator
//
//  Created by Quang on 14/10/25.
//

import Foundation
import SwiftUI

struct MainView: View {
    @StateObject private var appState = AppState.shared
    @EnvironmentObject var appCoordinator: AppCoordinator

    var body: some View {
        BaseView(coordinator: appCoordinator) {
            switch appState.appStateEnum {
            case .authenticated:
                appCoordinator.destination(for: .main)
            case .unAuthenticated:
                appCoordinator.destination(for: .login)
            case .forceUpdate:
                appCoordinator.destination(for: .update)
            }
        }
    }
}
