import Foundation
import Vision
import Dependencies
import CommonModels

extension PoseDetector: DependencyKey {
    public static var liveValue = Self(
        detectPoses: { image in
            let humanBodyPoseRequest = VNDetectHumanBodyPoseRequest()
            let visionRequestHandler = VNImageRequestHandler(cgImage: image)
            var results: [VNHumanBodyPoseObservation] = []

            do {
                try visionRequestHandler.perform([humanBodyPoseRequest])
                results.append(contentsOf: humanBodyPoseRequest.results ?? [])
            } catch {
                print("Human Pose Request failed: \(error)")
            }

            guard !results.isEmpty else { return [:] }
            return convertObservationToJoint(sourceImage: image, observation: results[0])
        }
    )
}
