//
//
//  AppCoordinator.swift
//  QCoordinator
//
//  Created by Quang on 14/10/25.
//

import Foundation
import SwiftUI

enum ProfileRoute {
    case profile
}

final class ProfileCoordinator: Coordinator {
    typealias Route = ProfileRoute

    func destination(for route: ProfileRoute) -> DestinationView {
        switch route {
        case .profile:
            DestinationView(ProfileView())
        }
    }
}
