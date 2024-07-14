import Dependencies
import Foundation
import PoseEstimation
import CommonModels
import Math

extension PoseEstimationService: DependencyKey {
    public static var liveValue: Self {
        return Self { joints, acceptedVariationValue in
            var poseWasDetected = false
            var leftCheckState: PoseJoint.Validation = .unchecked
            var rightCheckState: PoseJoint.Validation = .unchecked

            if let leftWristPos = joints[.leftWrist]?.position,
               let leftShoulderPos = joints[.leftShoulder]?.position {

                if PointMath.isPointsNearEnougthX(
                    first: leftWristPos,
                    second: leftShoulderPos,
                    value: acceptedVariationValue
                ) {
                    leftCheckState = .correct
                } else {
                    leftCheckState = .wrong
                }
            }

            if let rightWristPos = joints[.leftWrist]?.position,
               let rightShoulderPos = joints[.leftShoulder]?.position {

                if PointMath.isPointsNearEnougthX(
                    first: rightWristPos,
                    second: rightShoulderPos,
                    value: acceptedVariationValue
                ) {
                    rightCheckState = .correct
                } else {
                    rightCheckState = .wrong
                }
            }

            if rightCheckState == .correct ||
                leftCheckState == .correct {
                poseWasDetected = true
                joints[.leftWrist]?.validationStatus = .correct
                joints[.leftElbow]?.validationStatus = .correct
                joints[.leftShoulder]?.validationStatus = .correct

                joints[.rightWrist]?.validationStatus = .correct
                joints[.rightElbow]?.validationStatus = .correct
                joints[.rightShoulder]?.validationStatus = .correct
            } else {
                poseWasDetected = false
                joints[.leftWrist]?.validationStatus = .wrong
                joints[.leftElbow]?.validationStatus = .wrong
                joints[.leftShoulder]?.validationStatus = .wrong

                joints[.rightWrist]?.validationStatus = .wrong
                joints[.rightElbow]?.validationStatus = .wrong
                joints[.rightShoulder]?.validationStatus = .wrong
            }
            return poseWasDetected
        } checkElbowPoseHands: { joints, acceptedVariationValue in
            var poseWasDetected = false
            var leftCheckState: PoseJoint.Validation = .unchecked
            var rightCheckState: PoseJoint.Validation = .unchecked

            if let leftWristPos = joints[.leftWrist]?.position,
               let leftShoulderPos = joints[.leftShoulder]?.position,
               let leftElbowPos = joints[.leftElbow]?.position {

                if PointMath.isPointsNearEnougthY(
                    first: leftWristPos,
                    second: leftElbowPos,
                    value: acceptedVariationValue
                ) && PointMath.isPointsNearEnougthX(
                    first: leftShoulderPos,
                    second: leftElbowPos,
                    value: acceptedVariationValue
                ) {
                    leftCheckState = .correct
                } else {
                    leftCheckState = .wrong
                }
            }

            if let rightWristPos = joints[.leftWrist]?.position,
               let rightShoulderPos = joints[.leftShoulder]?.position,
               let rightElbowPos = joints[.rightElbow]?.position {

                if PointMath.isPointsNearEnougthY(
                    first: rightWristPos,
                    second: rightElbowPos,
                    value: acceptedVariationValue
                ) && PointMath.isPointsNearEnougthX(
                    first: rightShoulderPos,
                    second: rightElbowPos,
                    value: acceptedVariationValue
                ) {
                    rightCheckState = .correct
                } else {
                    rightCheckState = .wrong
                }
            }

            if rightCheckState == .correct ||
                leftCheckState == .correct {
                poseWasDetected = true
                joints[.leftWrist]?.validationStatus = .correct
                joints[.leftElbow]?.validationStatus = .correct
                joints[.leftShoulder]?.validationStatus = .correct

                joints[.rightWrist]?.validationStatus = .correct
                joints[.rightElbow]?.validationStatus = .correct
                joints[.rightShoulder]?.validationStatus = .correct
            } else {
                poseWasDetected = false
                joints[.leftWrist]?.validationStatus = .wrong
                joints[.leftElbow]?.validationStatus = .wrong
                joints[.leftShoulder]?.validationStatus = .wrong

                joints[.rightWrist]?.validationStatus = .wrong
                joints[.rightElbow]?.validationStatus = .wrong
                joints[.rightShoulder]?.validationStatus = .wrong
            }

            return poseWasDetected
        } checkBodyForElbowPose: { joints, acceptedVariationValue in
            guard let neckPos = joints[.neck]?.position,
                  let rootPos = joints[.root]?.position else { return }

            if PointMath.isPointsNearEnougthY(
                first: neckPos,
                second: rootPos,
                value: acceptedVariationValue
            ) {
                joints[.neck]?.validationStatus = .correct
                joints[.root]?.validationStatus = .correct
            }

            guard let anklePos = joints[.leftAnkle]?.position ?? joints[.rightAnkle]?.position else { return }
            guard let rootPos = joints[.root]?.position,
                  let leftKnee = joints[.leftKnee]?.position,
                  let rightKnee = joints[.rightKnee]?.position else { return }

            let bodyLine = LineMath.calculateLineParameters(point1: anklePos, point2: rootPos)
            var crossPoint = LineMath.findNearestPointFromStartOnLine(line: bodyLine, start: leftKnee)
            var vector = PointMath.vectorBetweenPoints(first: leftKnee, second: crossPoint)
            var variation = PointMath.vectorLength(vectorCoors: vector)

            if variation <= acceptedVariationValue {
                joints[.leftKnee]?.validationStatus = .correct
                joints[.leftAnkle]?.validationStatus = .correct
            }

            crossPoint = LineMath.findNearestPointFromStartOnLine(line: bodyLine, start: rightKnee)
            vector = PointMath.vectorBetweenPoints(first: rightKnee, second: crossPoint)
            variation = PointMath.vectorLength(vectorCoors: vector)

            if variation <= acceptedVariationValue {
                joints[.rightKnee]?.validationStatus = .correct
                joints[.rightAnkle]?.validationStatus = .correct
            }
        } checkBodyForStraitPose: { joints, acceptedVariationValue in
            guard let anklePos = joints[.leftAnkle]?.position ?? joints[.rightAnkle]?.position else { return }
            guard let neckPos = joints[.neck]?.position,
                  let rootPos = joints[.root]?.position,
                  let leftKnee = joints[.leftKnee]?.position,
                  let rightKnee = joints[.rightKnee]?.position else { return }

            let bodyLine = LineMath.calculateLineParameters(point1: anklePos, point2: neckPos)
            var crossPoint = LineMath.findNearestPointFromStartOnLine(line: bodyLine, start: rootPos)
            var vector = PointMath.vectorBetweenPoints(first: rootPos, second: crossPoint)
            var variation = PointMath.vectorLength(vectorCoors: vector)

            if variation <= acceptedVariationValue {
                joints[.neck]?.validationStatus = .correct
                joints[.root]?.validationStatus = .correct
            }

            crossPoint = LineMath.findNearestPointFromStartOnLine(line: bodyLine, start: leftKnee)
            vector = PointMath.vectorBetweenPoints(first: leftKnee, second: crossPoint)
            variation = PointMath.vectorLength(vectorCoors: vector)

            if variation <= acceptedVariationValue {
                joints[.leftKnee]?.validationStatus = .correct
                joints[.leftAnkle]?.validationStatus = .correct
            }

            crossPoint = LineMath.findNearestPointFromStartOnLine(line: bodyLine, start: rightKnee)
            vector = PointMath.vectorBetweenPoints(first: rightKnee, second: crossPoint)
            variation = PointMath.vectorLength(vectorCoors: vector)

            if variation <= acceptedVariationValue {
                joints[.rightKnee]?.validationStatus = .correct
                joints[.rightAnkle]?.validationStatus = .correct
            }
        }
    }
}
