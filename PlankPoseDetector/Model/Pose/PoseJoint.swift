//
//  PoseJoint.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 29.01.2023.
//

import Foundation
import UIKit
import CoreGraphics

class PoseJoint {
    enum Name: String, CaseIterable {
        case nose
        case leftEye
        case rightEye
        case leftEar
        case rightEar
        case leftShoulder
        case rightShoulder
        case leftElbow
        case rightElbow
        case leftWrist
        case rightWrist
        case leftHip
        case rightHip
        case leftKnee
        case rightKnee
        case leftAnkle
        case rightAnkle
        case neck
        case root
    }

    enum Validation: String {
        case unchecked
        case correct
        case wrong

        var color: UIColor {
            switch self {
            case .correct:
                return .green
            case .wrong:
                return .red
            case .unchecked:
                return .orange
            }
        }
    }

    let name: Name
    var position: CGPoint
    var confidence: Double
    var validationStatus: Validation

    init(
        name: Name,
        position: CGPoint = .zero,
        confidence: Double = 0,
        validationStatus: Validation = .unchecked
    ) {
        self.name = name
        self.position = position
        self.confidence = confidence
        self.validationStatus = validationStatus
    }
}
