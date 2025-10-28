//
//
//  AppCoordinator.swift
//  QCoordinator
//
//  Created by Quang on 14/10/25.
//

import Foundation
import SwiftUI

typealias DestinationView = AnyView

enum HomeRoute: Hashable {
    case home
}

final class HomeCoordinator: Coordinator {
    typealias Route = HomeRoute

    func destination(for route: HomeRoute) -> DestinationView {
        switch route {
        case .home:
            DestinationView(HomeView())
        }
    }
}
