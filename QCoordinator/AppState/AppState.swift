//
//  AppState.swift
//  QCoordinator
//
//  Created by Quang on 14/10/25.
//

import Foundation

enum AppStateEnum {
    case authenticated
    case unAuthenticated
    case forceUpdate
}

final class AppState: NSObject, ObservableObject {
    @Published var userId: String = ""
    @Published var appStateEnum: AppStateEnum = .authenticated

    static let shared = AppState()

    func updateUserId(_ newValue: String) {
        userId = newValue
    }

    func checkUpdate() {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 5,
            execute: {
                self.appStateEnum = .forceUpdate
            }
        )
    }
}
