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

            if let leftWristPos = joints[PoseJoint.Name.leftWrist]?.position,
               let leftShoulderPos = joints[PoseJoint.Name.leftShoulder]?.position {

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

            if let rightWristPos = joints[PoseJoint.Name.leftWrist]?.position,
               let rightShoulderPos = joints[PoseJoint.Name.leftShoulder]?.position {

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
                joints[PoseJoint.Name.leftWrist]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.leftElbow]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.leftShoulder]?.validationStatus = PoseJoint.Validation.correct

                joints[PoseJoint.Name.rightWrist]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.rightElbow]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.rightShoulder]?.validationStatus = PoseJoint.Validation.correct
            } else {
                poseWasDetected = false
                joints[PoseJoint.Name.leftWrist]?.validationStatus = PoseJoint.Validation.wrong
                joints[PoseJoint.Name.leftElbow]?.validationStatus = PoseJoint.Validation.wrong
                joints[PoseJoint.Name.leftShoulder]?.validationStatus = PoseJoint.Validation.wrong

                joints[PoseJoint.Name.rightWrist]?.validationStatus = PoseJoint.Validation.wrong
                joints[PoseJoint.Name.rightElbow]?.validationStatus = PoseJoint.Validation.wrong
                joints[PoseJoint.Name.rightShoulder]?.validationStatus = PoseJoint.Validation.wrong
            }
            return poseWasDetected
        } checkElbowPoseHands: { joints, acceptedVariationValue in
            var poseWasDetected = false
            var leftCheckState: PoseJoint.Validation = PoseJoint.Validation.unchecked
            var rightCheckState: PoseJoint.Validation = PoseJoint.Validation.unchecked

            if let leftWristPos = joints[PoseJoint.Name.leftWrist]?.position,
               let leftShoulderPos = joints[PoseJoint.Name.leftShoulder]?.position,
               let leftElbowPos = joints[PoseJoint.Name.leftElbow]?.position {

                if PointMath.isPointsNearEnougthY(
                    first: leftWristPos,
                    second: leftElbowPos,
                    value: acceptedVariationValue
                ) && PointMath.isPointsNearEnougthX(
                    first: leftShoulderPos,
                    second: leftElbowPos,
                    value: acceptedVariationValue
                ) {
                    leftCheckState = PoseJoint.Validation.correct
                } else {
                    leftCheckState = PoseJoint.Validation.wrong
                }
            }

            if let rightWristPos = joints[PoseJoint.Name.leftWrist]?.position,
               let rightShoulderPos = joints[PoseJoint.Name.leftShoulder]?.position,
               let rightElbowPos = joints[PoseJoint.Name.rightElbow]?.position {

                if PointMath.isPointsNearEnougthY(
                    first: rightWristPos,
                    second: rightElbowPos,
                    value: acceptedVariationValue
                ) && PointMath.isPointsNearEnougthX(
                    first: rightShoulderPos,
                    second: rightElbowPos,
                    value: acceptedVariationValue
                ) {
                    rightCheckState = PoseJoint.Validation.correct
                } else {
                    rightCheckState = PoseJoint.Validation.wrong
                }
            }

            if rightCheckState == PoseJoint.Validation.correct ||
                leftCheckState == PoseJoint.Validation.correct {
                poseWasDetected = true
                joints[PoseJoint.Name.leftWrist]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.leftElbow]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.leftShoulder]?.validationStatus = PoseJoint.Validation.correct

                joints[PoseJoint.Name.rightWrist]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.rightElbow]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.rightShoulder]?.validationStatus = PoseJoint.Validation.correct
            } else {
                poseWasDetected = false
                joints[PoseJoint.Name.leftWrist]?.validationStatus = PoseJoint.Validation.wrong
                joints[PoseJoint.Name.leftElbow]?.validationStatus = PoseJoint.Validation.wrong
                joints[PoseJoint.Name.leftShoulder]?.validationStatus = PoseJoint.Validation.wrong

                joints[PoseJoint.Name.rightWrist]?.validationStatus = PoseJoint.Validation.wrong
                joints[PoseJoint.Name.rightElbow]?.validationStatus = PoseJoint.Validation.wrong
                joints[PoseJoint.Name.rightShoulder]?.validationStatus = PoseJoint.Validation.wrong
            }

            return poseWasDetected
        } checkBodyForElbowPose: { joints, acceptedVariationValue in
            guard let neckPos = joints[PoseJoint.Name.neck]?.position,
                  let rootPos = joints[PoseJoint.Name.root]?.position else { return }

            if PointMath.isPointsNearEnougthY(
                first: neckPos,
                second: rootPos,
                value: acceptedVariationValue
            ) {
                joints[PoseJoint.Name.neck]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.root]?.validationStatus = PoseJoint.Validation.correct
            }

            guard let anklePos = joints[PoseJoint.Name.leftAnkle]?.position ?? joints[PoseJoint.Name.rightAnkle]?.position else { return }
            guard let rootPos = joints[PoseJoint.Name.root]?.position,
                  let leftKnee = joints[PoseJoint.Name.leftKnee]?.position,
                  let rightKnee = joints[PoseJoint.Name.rightKnee]?.position else { return }

            let bodyLine = LineMath.calculateLineParameters(point1: anklePos, point2: rootPos)
            var crossPoint = LineMath.findNearestPointFromStartOnLine(line: bodyLine, start: leftKnee)
            var vector = PointMath.vectorBetweenPoints(first: leftKnee, second: crossPoint)
            var variation = PointMath.vectorLength(vectorCoors: vector)

            if variation <= acceptedVariationValue {
                joints[PoseJoint.Name.leftKnee]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.leftAnkle]?.validationStatus = PoseJoint.Validation.correct
            }

            crossPoint = LineMath.findNearestPointFromStartOnLine(line: bodyLine, start: rightKnee)
            vector = PointMath.vectorBetweenPoints(first: rightKnee, second: crossPoint)
            variation = PointMath.vectorLength(vectorCoors: vector)

            if variation <= acceptedVariationValue {
                joints[PoseJoint.Name.rightKnee]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.rightAnkle]?.validationStatus = PoseJoint.Validation.correct
            }
        } checkBodyForStraitPose: { joints, acceptedVariationValue in
            guard let anklePos = joints[PoseJoint.Name.leftAnkle]?.position ?? joints[PoseJoint.Name.rightAnkle]?.position else { return }
            guard let neckPos = joints[PoseJoint.Name.neck]?.position,
                  let rootPos = joints[PoseJoint.Name.root]?.position,
                  let leftKnee = joints[PoseJoint.Name.leftKnee]?.position,
                  let rightKnee = joints[PoseJoint.Name.rightKnee]?.position else { return }

            let bodyLine = LineMath.calculateLineParameters(point1: anklePos, point2: neckPos)
            var crossPoint = LineMath.findNearestPointFromStartOnLine(line: bodyLine, start: rootPos)
            var vector = PointMath.vectorBetweenPoints(first: rootPos, second: crossPoint)
            var variation = PointMath.vectorLength(vectorCoors: vector)

            if variation <= acceptedVariationValue {
                joints[PoseJoint.Name.neck]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.root]?.validationStatus = PoseJoint.Validation.correct
            }

            crossPoint = LineMath.findNearestPointFromStartOnLine(line: bodyLine, start: leftKnee)
            vector = PointMath.vectorBetweenPoints(first: leftKnee, second: crossPoint)
            variation = PointMath.vectorLength(vectorCoors: vector)

            if variation <= acceptedVariationValue {
                joints[PoseJoint.Name.leftKnee]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.leftAnkle]?.validationStatus = PoseJoint.Validation.correct
            }

            crossPoint = LineMath.findNearestPointFromStartOnLine(line: bodyLine, start: rightKnee)
            vector = PointMath.vectorBetweenPoints(first: rightKnee, second: crossPoint)
            variation = PointMath.vectorLength(vectorCoors: vector)

            if variation <= acceptedVariationValue {
                joints[PoseJoint.Name.rightKnee]?.validationStatus = PoseJoint.Validation.correct
                joints[PoseJoint.Name.rightAnkle]?.validationStatus = PoseJoint.Validation.correct
            }
        }
    }
}
