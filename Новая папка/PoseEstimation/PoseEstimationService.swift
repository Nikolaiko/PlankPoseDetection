//
//  PoseEstimationService.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 12.09.2023.
//

import Foundation
import PoseDetection
import CommonModels

protocol PoseEstimationService {
    func estimatePoseJoints(
        joints: [PoseJoint.Name: PoseJoint],
        imageSize: CGSize
    ) -> [PoseJoint.Name: PoseJoint]
}
