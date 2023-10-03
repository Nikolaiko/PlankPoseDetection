//
//  PlankPoseEstimation.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 12.09.2023.
//

import Foundation
import PointMath

class PlankPoseEstimation: PoseEstimationService {
    private static let acceptedVariationPercent: Double = 3

    private var ankleToHeadDistance: Double = 0
    private var acceptedVariationValue: Double = 0

    func estimatePoseJoints(
        joints: [PoseJoint.Name: PoseJoint],
        imageSize: CGSize
    ) -> [PoseJoint.Name: PoseJoint] {
        var poseType: PlankPoseType = .undefined

        calculateAcceptedVariations(joints: joints, imageSize: imageSize)

        if checkStraitPoseHands(joints: joints) {
            poseType = .straitHands
        } else if checkElbowPoseHands(joints: joints) {
            poseType = .elbow
        }

        guard poseType != .undefined else { return joints }

        checkBack(joints: joints, poseType: poseType)

    return joints
}

    private func checkBack(joints: [PoseJoint.Name: PoseJoint], poseType: PlankPoseType) {
        switch poseType {
        case .elbow:
            checkBackForElbowPose(joints: joints)
        case .straitHands:
            print("Strait")
        case .undefined:
            return
        }
    }

    private func checkBackForElbowPose(joints: [PoseJoint.Name: PoseJoint]) {
        guard let neckPos = joints[.neck]?.position,
              let rootPos = joints[.root]?.position else { return }
        
        if PointMath.isPointsNearEnougthY(
            first: neckPos,
            second: rootPos,
            value: acceptedVariationValue
        ) {
            joints[.neck]?.validationStatus = .correct
            joints[.root]?.validationStatus = .correct
        }
    }

    private func checkStraitPoseHands(joints: [PoseJoint.Name: PoseJoint]) -> Bool {
        var poseWasDetected = false
        var leftCheckState: PoseJoint.Validation = .unchecked
        var rightCheckState: PoseJoint.Validation = .unchecked

        if let leftWristPos = joints[.leftWrist]?.position,
           let leftShoulderPos = joints[.leftShoulder]?.position {

            if PointMath.isPointsNearEnougthX(
                first: leftWristPos,
                second: leftShoulderPos,
                value: acceptedVariationValue
            ) {
                leftCheckState = .correct
            } else {
                leftCheckState = .wrong
            }
        }

        if let rightWristPos = joints[.leftWrist]?.position,
            let rightShoulderPos = joints[.leftShoulder]?.position {

            if PointMath.isPointsNearEnougthX(
                first: rightWristPos,
                second: rightShoulderPos,
                value: acceptedVariationValue
            ) {
                rightCheckState = .correct
            } else {
                rightCheckState = .wrong
            }
        }

        if rightCheckState == .correct ||
            leftCheckState == .correct {
            poseWasDetected = true
            joints[.leftWrist]?.validationStatus = .correct
            joints[.leftElbow]?.validationStatus = .correct
            joints[.leftShoulder]?.validationStatus = .correct

            joints[.rightWrist]?.validationStatus = .correct
            joints[.rightElbow]?.validationStatus = .correct
            joints[.rightShoulder]?.validationStatus = .correct
        } else {
            poseWasDetected = false
            joints[.leftWrist]?.validationStatus = .wrong
            joints[.leftElbow]?.validationStatus = .wrong
            joints[.leftShoulder]?.validationStatus = .wrong

            joints[.rightWrist]?.validationStatus = .wrong
            joints[.rightElbow]?.validationStatus = .wrong
            joints[.rightShoulder]?.validationStatus = .wrong
        }
        return poseWasDetected
    }

    private func checkElbowPoseHands(joints: [PoseJoint.Name: PoseJoint]) -> Bool {
        var poseWasDetected = false
        var leftCheckState: PoseJoint.Validation = .unchecked
        var rightCheckState: PoseJoint.Validation = .unchecked

        if let leftWristPos = joints[.leftWrist]?.position,
           let leftShoulderPos = joints[.leftShoulder]?.position,
           let leftElbowPos = joints[.leftElbow]?.position {

            if PointMath.isPointsNearEnougthY(
                first: leftWristPos,
                second: leftElbowPos,
                value: acceptedVariationValue
            ) && PointMath.isPointsNearEnougthX(
                first: leftShoulderPos,
                second: leftElbowPos,
                value: acceptedVariationValue
            ) {
                leftCheckState = .correct
            } else {
                leftCheckState = .wrong
            }
        }

        if let rightWristPos = joints[.leftWrist]?.position,
           let rightShoulderPos = joints[.leftShoulder]?.position,
           let rightElbowPos = joints[.rightElbow]?.position {

            if PointMath.isPointsNearEnougthY(
                first: rightWristPos,
                second: rightElbowPos,
                value: acceptedVariationValue
            ) && PointMath.isPointsNearEnougthX(
                first: rightShoulderPos,
                second: rightElbowPos,
                value: acceptedVariationValue
            ) {
                rightCheckState = .correct
            } else {
                rightCheckState = .wrong
            }
        }

        if rightCheckState == .correct ||
            leftCheckState == .correct {
            poseWasDetected = true
            joints[.leftWrist]?.validationStatus = .correct
            joints[.leftElbow]?.validationStatus = .correct
            joints[.leftShoulder]?.validationStatus = .correct

            joints[.rightWrist]?.validationStatus = .correct
            joints[.rightElbow]?.validationStatus = .correct
            joints[.rightShoulder]?.validationStatus = .correct
        } else {
            poseWasDetected = false
            joints[.leftWrist]?.validationStatus = .wrong
            joints[.leftElbow]?.validationStatus = .wrong
            joints[.leftShoulder]?.validationStatus = .wrong

            joints[.rightWrist]?.validationStatus = .wrong
            joints[.rightElbow]?.validationStatus = .wrong
            joints[.rightShoulder]?.validationStatus = .wrong
        }

        return poseWasDetected
    }

    private func calculateAcceptedVariations(
        joints: [PoseJoint.Name: PoseJoint],
        imageSize: CGSize
    ) {
        if let legPoint = joints[.leftAnkle]?.position ?? joints[.rightAnkle]?.position,
           let neckPoint = joints[.neck]?.position {
            let distance = abs(legPoint.x - neckPoint.x)
            acceptedVariationValue = 3 * distance / 100
        } else {
            acceptedVariationValue = 3 * imageSize.width / 100
        }
    }
}
