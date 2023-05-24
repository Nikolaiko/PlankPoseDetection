//
//  PlankAppDelegate.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 20.05.2023.
//

import Foundation
import UIKit

class PlankAppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        print("App Delegate!")
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = PlankAppSceneDelegate.self
        return sceneConfig
    }
}
