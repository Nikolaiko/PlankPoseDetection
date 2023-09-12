//
//  PoseEstimationService.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 12.09.2023.
//

import Foundation

protocol PoseEstimationService {
    func estimatePoseJoints(joints: [PoseJoint.Name: PoseJoint]) -> [PoseJoint.Name: PoseJoint]
}
