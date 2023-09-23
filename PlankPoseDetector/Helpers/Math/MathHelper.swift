//
//  MathHelper.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 21.09.2023.
//

import Foundation

enum MathHelper {
    static func isPointsNearEnougthY(
        first: CGPoint,
        second: CGPoint,
        value: Double
    ) -> Bool {
        abs(first.y - second.y) <= value
    }

    static func isPointsNearEnougthX(
        first: CGPoint,
        second: CGPoint,
        value: Double
    ) -> Bool {
        abs(first.x - second.x) <= value
    }
}
