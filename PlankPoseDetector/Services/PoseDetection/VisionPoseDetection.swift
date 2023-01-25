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
    private var detectTask: Task<[VNHumanBodyPoseObservation], Never>? = nil
    private let humanBodyPoseRequest = VNDetectHumanBodyPoseRequest()

    func detectPoseOnImage(image: UIImage) async -> UIImage? {
        if detectTask != nil {
            detectTask?.cancel()
            detectTask = nil
        }

        detectTask = Task {
            let visionRequestHandler = VNImageRequestHandler(cgImage: image.cgImage!)
            var results: [VNHumanBodyPoseObservation] = []

            do {
                try visionRequestHandler.perform([humanBodyPoseRequest])
                results.append(contentsOf: humanBodyPoseRequest.results ?? [])
            } catch {
                print("Human Pose Request failed: \(error)")
            }
            detectTask = nil
            return results
        }

        guard let taskResults = await detectTask?.value, !taskResults.isEmpty else { return nil }
        return drawPoseOnImage(sourceImage: image.cgImage!, observation: taskResults[0])
    }

    private func drawPoseOnImage(sourceImage: CGImage, observation: VNHumanBodyPoseObservation) -> UIImage {
        let dstImageSize = CGSize(width: sourceImage.width, height: sourceImage.height)
        let dstImageFormat = UIGraphicsImageRendererFormat()
        dstImageFormat.scale = 1

        let renderer = UIGraphicsImageRenderer(
            size: dstImageSize,
            format: dstImageFormat
        )

        let dstImage = renderer.image { rendererContext in
            rendererContext.cgContext.saveGState()
            rendererContext.cgContext.scaleBy(x: 1.0, y: -1.0)
            let drawingRect = CGRect(
                x: 0,
                y: -sourceImage.height,
                width: sourceImage.width,
                height: sourceImage.height
            )
            rendererContext.cgContext.draw(sourceImage, in: drawingRect)
            rendererContext.cgContext.restoreGState()

            guard let recognizedPoints =
                    try? observation.recognizedPoints(.torso) else { return }

            let torsoJointNames: [VNHumanBodyPoseObservation.JointName] = [
                .neck,
                .rightShoulder,
                .rightHip,
                .root,
                .leftHip,
                .leftShoulder
            ]

            let imagePoints: [CGPoint] = torsoJointNames.compactMap {
                guard let point = recognizedPoints[$0], point.confidence > 0 else { return nil }
                var normalized: CGPoint = VNImagePointForNormalizedPoint(
                    point.location,
                    sourceImage.width,
                    sourceImage.height
                )
                normalized.y = CGFloat(sourceImage.height) - normalized.y
                return normalized
            }

            imagePoints.forEach { point in
                UIColor.red.setFill()
                UIColor.red.setStroke()
                rendererContext.cgContext.fillEllipse(in: CGRect(x: point.x, y: point.y, width: 100, height: 100))
            }
        }
        return dstImage
    }

}
