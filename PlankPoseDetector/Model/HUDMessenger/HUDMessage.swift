//
//  HUDMessage.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 20.05.2023.
//

import Foundation

struct HUDMessage: Equatable {
    let message: String
    let priority: HUDMessagePriority
}
