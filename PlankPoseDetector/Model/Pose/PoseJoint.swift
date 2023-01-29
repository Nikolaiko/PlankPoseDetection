//
//  PoseJoint.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 29.01.2023.
//

import Foundation

import CoreGraphics

class PoseJoint {
    enum Name: Int, CaseIterable {
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
    }

    let name: Name
    var position: CGPoint
    var confidence: Double

    init(
        name: Name,
        position: CGPoint = .zero,
        confidence: Double = 0
    ) {
        self.name = name
        self.position = position
        self.confidence = confidence
    }
}
