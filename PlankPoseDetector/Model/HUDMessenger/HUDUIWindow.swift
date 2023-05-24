//
//  HUDUIWindow.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 24.05.2023.
//

import Foundation
import UIKit

class HUDUIWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event) else { return nil }
        return rootViewController?.view == hitView ? nil : hitView
    }
}
