//
//  TabItem.swift
//  QCoordinator
//
//  Created by Quang on 15/10/25.
//

enum TabItem: Int, CaseIterable {
    case home = 0
    case files = 1
    case profile = 2

    var title: String {
        switch self {
        case .home: return "Home"
        case .files: return "Files"
        case .profile: return "Profile"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .files: return "folder.fill"
        case .profile: return "person.fill"
        }
    }
}
