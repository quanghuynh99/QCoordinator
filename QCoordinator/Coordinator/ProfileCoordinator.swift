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
    func destination(for route: ProfileRoute) -> DestinationView {
        switch route {
        case .profile:
            DestinationView(ProfileView())
        }
    }
}
