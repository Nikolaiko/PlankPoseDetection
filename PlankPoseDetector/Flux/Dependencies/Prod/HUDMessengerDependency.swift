//
//  HUDMessengerDependency.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 24.05.2023.
//

import Foundation
import Dependencies

enum HUDMessengerDependency: DependencyKey {
    static var liveValue: any HUDMessenger = StaticHUDMessenger.shared
    static var testValue: any HUDMessenger = StaticHUDMessenger.shared
    static var previewValue: any HUDMessenger = StaticHUDMessenger.shared
}

extension DependencyValues {
  var hudMessenger: any HUDMessenger {
    get { self[HUDMessengerDependency.self] }
    set { self[HUDMessengerDependency.self] = newValue }
  }
}
