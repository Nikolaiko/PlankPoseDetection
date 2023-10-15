//
//  PoseDetectorAdapter.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 15.10.2023.
//

import Foundation
import PoseDetection
import UIKit

struct PoseDetectorAdapter: PoseDetector {
    private let detector = VisionPoseDetection()

    func detectPoseOnImage(image: UIImage) -> [PoseDetection.PoseJoint.Name : PoseDetection.PoseJoint] {
        detector.detectPoseOnImage(image: image)
    }
}
