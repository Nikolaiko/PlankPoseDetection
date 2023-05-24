//
//  PlankAppSceneDelegate.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 20.05.2023.
//

import Foundation
import UIKit
import SwiftUI

class PlankAppSceneDelegate: NSObject, UIWindowSceneDelegate {
    var hudWindow: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            setupHUDWindow(in: windowScene)
        }
    }

    func setupHUDWindow(in scene: UIWindowScene) {
        print("setup insiade app delegate")
        let hudWindow = HUDUIWindow(windowScene: scene)
        let hudViewController = UIHostingController(rootView: HUDWindowView())
        hudViewController.view.backgroundColor = .clear
        hudWindow.rootViewController = hudViewController
        hudWindow.isHidden = false

        self.hudWindow = hudWindow
    }
}
