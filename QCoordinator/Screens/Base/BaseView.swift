//
//  BaseView.swift
//  QCoordinator
//
//  Created by Quang on 15/10/25.
//

import SwiftUI

struct BaseView<Content: View>: View {
    @ObservedObject var coordinator: AppCoordinator
    let content: Content

    init(
        coordinator: AppCoordinator,
        @ViewBuilder content: () -> Content
    ) {
        self.coordinator = coordinator
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            content
                .navigationDestination(for: AppRoute.self) { route in
                    coordinator.destination(for: route)
                }
        }
        .environmentObject(coordinator)
    }
}
