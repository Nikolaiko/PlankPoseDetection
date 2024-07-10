import Foundation
import Vision
import CommonModels

func convertObservationToJoint(
    sourceImage: CGImage,
    observation: VNHumanBodyPoseObservation
) -> [PoseJoint.Name: PoseJoint] {
    guard let recognizedPoints = try? observation.recognizedPoints(.all) else {
        return [:]
    }

    var imagePoints: [PoseJoint.Name: PoseJoint] = [:]
    recognizedPoints.forEach { pair in
        let currentPoint = pair.value
        let jointName = pair.key
        guard
            currentPoint.confidence > 0,
            let jointType = PoseJoint.Name.fromVisionJoint(joint: jointName)
        else { return }

        if jointName == .leftWrist {
            print("Left W Not Normalized : \(currentPoint.location)")
        }

        if jointName == .leftShoulder {
            print("Left S Not Normalized : \(currentPoint.location)")
        }

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
