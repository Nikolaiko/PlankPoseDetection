//
//  HUDMessenger.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 20.05.2023.
//

import Foundation

protocol HUDMessenger {
    var callback: HUDCallback? { get set}

    func sendMessage(message: HUDMessage)
}
