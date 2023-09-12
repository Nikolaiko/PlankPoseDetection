//
//  VisionPoseDetection.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import Foundation
import Vision
import UIKit

class VisionPoseDetection: PoseDetector {
    private let humanBodyPoseRequest = VNDetectHumanBodyPoseRequest()

    func detectPoseOnImage(image: UIImage) -> [PoseJoint.Name: PoseJoint] {
        let visionRequestHandler = VNImageRequestHandler(cgImage: image.cgImage!)
        var results: [VNHumanBodyPoseObservation] = []

        do {
            try visionRequestHandler.perform([humanBodyPoseRequest])
            results.append(contentsOf: humanBodyPoseRequest.results ?? [])
        } catch {
            print("Human Pose Request failed: \(error)")
        }

        guard !results.isEmpty else { return [:] }
        return convertObservationToJoint(sourceImage: image.cgImage!, observation: results[0])
    }

    private func convertObservationToJoint(
        sourceImage: CGImage,
        observation: VNHumanBodyPoseObservation
    ) -> [PoseJoint.Name: PoseJoint] {
        guard let recognizedPoints =
                try? observation.recognizedPoints(.all) else { return [:] }

        var imagePoints: [PoseJoint.Name: PoseJoint] = [:]
        recognizedPoints.forEach { pair in
            let currentPoint = pair.value
            let jointName = pair.key            
            guard
                currentPoint.confidence > 0,
                let jointType = PoseJoint.Name.fromVisionJoint(joint: jointName)
            else { return }

            var normalized: CGPoint = VNImagePointForNormalizedPoint(
                currentPoint.location,
                sourceImage.width,
                sourceImage.height
            )            
            normalized.y = CGFloat(sourceImage.height) - normalized.y
            imagePoints[jointType] = PoseJoint(
                name: jointType,
                position: normalized,
                confidence: Double(currentPoint.confidence)
            )
        }
        return imagePoints
    }

}
