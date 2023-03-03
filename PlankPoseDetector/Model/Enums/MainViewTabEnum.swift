//
//  MainViewTabEnum.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import Foundation

enum MainViewTabEnum {
    case home
    case gallery
    case statistics
    case settings

    func getImageName(isSelected: Bool) -> String {
        switch self {
        case .settings:
            return isSelected
                ? BottomBarImageNames.profileSelectedIcon
                : BottomBarImageNames.profileUnSelectedIcon

        case .statistics:
            return isSelected
                ? BottomBarImageNames.activitySelectedIcon
                : BottomBarImageNames.activityUnSelectedIcon

        case .gallery:
            return isSelected
                ? BottomBarImageNames.cameraSelectedIcon
                : BottomBarImageNames.cameraUnSelectedIcon

        case .home:
            return isSelected
                ? BottomBarImageNames.homeSelectedIcon
                : BottomBarImageNames.homeUnSelectedIcon
        }
    }
}
