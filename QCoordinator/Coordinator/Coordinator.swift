//
//  Coordinator.swift
//  QCoordinator
//
//  Created by Quang on 15/10/25.
//

import Foundation
import SwiftUI

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()

    func cleanup() {
        path = NavigationPath()
    }
}
