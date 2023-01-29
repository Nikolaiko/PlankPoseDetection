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

    func detectPoseOnImage(image: UIImage) -> [PoseJoint] {
        let visionRequestHandler = VNImageRequestHandler(cgImage: image.cgImage!)
        var results: [VNHumanBodyPoseObservation] = []

        do {
            try visionRequestHandler.perform([humanBodyPoseRequest])
            results.append(contentsOf: humanBodyPoseRequest.results ?? [])
        } catch {
            print("Human Pose Request failed: \(error)")
        }

        guard !results.isEmpty else { return [] }
        return drawPoseOnImage(sourceImage: image.cgImage!, observation: results[0])
    }

    private func drawPoseOnImage(sourceImage: CGImage, observation: VNHumanBodyPoseObservation) -> [PoseJoint] {
        guard let recognizedPoints =
                try? observation.recognizedPoints(.all) else { return [] }

        let imagePoints: [PoseJoint] = recognizedPoints.compactMap { pair in
            let currentPoint = pair.value
            guard currentPoint.confidence > 0 else { return nil }
            var normalized: CGPoint = VNImagePointForNormalizedPoint(
                currentPoint.location,
                sourceImage.width,
                sourceImage.height
            )
            normalized.y = CGFloat(sourceImage.height) - normalized.y
            return PoseJoint(
                name: .leftEye,
                position: normalized,
                confidence: Double(currentPoint.confidence)
            )
        }
        return imagePoints
    }

}
