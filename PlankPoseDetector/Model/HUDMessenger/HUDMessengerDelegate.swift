//
//  HUDMessengerDelegate.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 20.05.2023.
//

import Foundation

protocol HUDMessengerDelegate {
    func receiveMessage(message: HUDMessage)
}
