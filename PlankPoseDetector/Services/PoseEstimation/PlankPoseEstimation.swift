//
//  PlankPoseEstimation.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 12.09.2023.
//

import Foundation

struct PlankPoseEstimation: PoseEstimationService {
    func estimatePoseJoints(
        joints: [PoseJoint.Name : PoseJoint]
    ) -> [PoseJoint.Name : PoseJoint] {

        joints[.leftWrist]?.validationStatus = .correct
        joints[.leftElbow]?.validationStatus = .correct
        joints[.leftShoulder]?.validationStatus = .correct

        joints[.rightWrist]?.validationStatus = .correct
        joints[.rightElbow]?.validationStatus = .correct
        joints[.rightShoulder]?.validationStatus = .correct


        return joints
    }
}
