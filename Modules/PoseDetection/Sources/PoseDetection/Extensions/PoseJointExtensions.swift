//
//  PoseJointExtensions.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 18.02.2023.
//

import Foundation
import Vision

extension PoseJoint.Name {
    public static func fromVisionJoint(joint: VNHumanBodyPoseObservation.JointName) -> PoseJoint.Name? {
        switch joint {
        case .leftShoulder:
            return .leftShoulder
        case .rightShoulder:
            return .rightShoulder

        case .neck:
            return .neck
        case .root:
            return .root

        case .leftElbow:
            return .leftElbow
        case .rightElbow:
            return .rightElbow

        case .leftWrist:
            return .leftWrist
        case .rightWrist:
            return .rightWrist

        case .leftHip:
            return .leftHip
        case .rightHip:
            return .rightHip

        case .leftKnee:
            return .leftKnee
        case .rightKnee:
            return .rightKnee

        case .leftAnkle:
            return .leftAnkle
        case .rightAnkle:
            return .rightAnkle

        default:
            return nil
        }
    }
}
