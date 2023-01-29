//
//  MainViewTabEnum.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import Foundation

enum MainViewTabEnum {
    case home
    case camera
    case workout
    case settings

    func getImageName(isSelected: Bool) -> String {
        switch self {
        case .settings:
            return isSelected
                ? BottomBarImageNames.profileSelectedIcon
                : BottomBarImageNames.profileUnSelectedIcon

        case .workout:
            return isSelected
                ? BottomBarImageNames.activitySelectedIcon
                : BottomBarImageNames.activityUnSelectedIcon

        case .camera:
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
