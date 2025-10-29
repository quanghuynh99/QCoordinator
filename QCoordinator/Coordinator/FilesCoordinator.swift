//
//
//  AppCoordinator.swift
//  QCoordinator
//
//  Created by Quang on 14/10/25.
//

import Foundation
import SwiftUI

enum FileRoute {
    case dashboard
}

final class FilesCoordinator: Coordinator {
    func destination(for route: FileRoute) -> DestinationView {
        switch route {
        case .dashboard:
            DestinationView(FilesView())
        }
    }
}
