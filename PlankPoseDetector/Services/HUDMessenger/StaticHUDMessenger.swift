//
//  StaticHUDMessenger.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 20.05.2023.
//

import Foundation

class StaticHUDMessenger: HUDMessenger {
    static let shared = StaticHUDMessenger()
    
    var callback: HUDCallback?

    private init() {}

    func sendMessage(message: HUDMessage) {        
        callback?(message)
    }
}
