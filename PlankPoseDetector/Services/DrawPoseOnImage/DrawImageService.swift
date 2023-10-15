//
//  DrawImageService.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 29.01.2023.
//

import Foundation
import UIKit
import PoseDetection

protocol DrawImageService {
    func drawPointsOnImage(sourceImage: UIImage, points: [PoseJoint.Name: PoseJoint]) -> UIImage
    func drawPointsOnTransparentImage(sourceImage: UIImage, points: [PoseJoint.Name: PoseJoint]) -> UIImage
}
