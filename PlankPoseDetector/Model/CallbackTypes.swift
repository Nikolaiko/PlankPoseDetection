//
//  CallbackTypes.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 17.02.2023.
//

import Foundation
import UIKit

typealias HUDCallback = (HUDMessage) -> Void
typealias FrameCallback = (CGImage?) -> Void
typealias VoidCallback = () -> Void
