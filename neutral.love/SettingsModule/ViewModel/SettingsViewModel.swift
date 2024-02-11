//
//  SettingsViewModel.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 05.12.2023.
//

import Foundation

enum SettingsViewNavigation {
    case profileSettings
    case theme
    case language
    case logout
    case noNavigation
}

struct ItemSettingsViewModel {
    let title: String
    let icon: String
    let isNavigatable: Bool
    let navigation: SettingsViewNavigation
    
    var isNotNavigatable: Bool {
        !self.isNavigatable
    }
}

final class SettingsViewModel {
    private var itemsSettingsViewModel: [ItemSettingsViewModel] = [
        ItemSettingsViewModel(title: "Profile Settings",
                              icon: "person",
                              isNavigatable: false,
                              navigation: .profileSettings),
        ItemSettingsViewModel(title: "Theme",
                              icon: "paintbrush",
                              isNavigatable: true,
                              navigation: .theme),
        ItemSettingsViewModel(title: "Language",
                              icon: "globe",
                              isNavigatable: true,
                              navigation: .language),
        ItemSettingsViewModel(title: "Log Out",
                              icon: "door.right.hand.open",
                              isNavigatable: false,
                              navigation: .logout),
        ItemSettingsViewModel(title: "Version App 1.0",
                              icon: "apps.iphone",
                              isNavigatable: false,
                              navigation: .noNavigation)
    ]
    private var auth: LogOutAuth?
    
    var settingsCount: Int {
        itemsSettingsViewModel.count
    }
    
    init(auth: LogOutAuth?) {
        self.auth = auth
    }
    
    func getItemSettingsViewModel(row: Int) -> ItemSettingsViewModel {
        itemsSettingsViewModel[row]
    }
    
    func cellSelected(row: Int) -> SettingsViewNavigation {
        let navigation = itemsSettingsViewModel[row].navigation
        if navigation == .logout {
            auth?.logOut()
        }
        return navigation
    }
}
