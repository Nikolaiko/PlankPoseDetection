//
//  AVPlayer+State.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 17.05.2023.
//

import Foundation
import AVFoundation

extension AVPlayer {
    func isPlaying() -> Bool {
        return rate != 0 && error == nil
    }
}
