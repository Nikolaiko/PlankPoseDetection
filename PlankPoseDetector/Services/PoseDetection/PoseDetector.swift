//
//  PoseDetector.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import Foundation
import UIKit
import PoseDetection

protocol PoseDetector {
    func detectPoseOnImage(image: UIImage) -> [PoseJoint.Name: PoseJoint]
}
