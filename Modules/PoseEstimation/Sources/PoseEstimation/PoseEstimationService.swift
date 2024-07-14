import Foundation
import CommonModels

public struct PoseEstimationService {
    public var checkStraitPoseHands: JointsValidator
    public var checkElbowPoseHands: JointsValidator
    public var checkBodyForElbowPose: JointsChecker
    public var checkBodyForStraitPose: JointsChecker

    public init(checkStraitPoseHands: @escaping JointsValidator,
                checkElbowPoseHands: @escaping JointsValidator,
                checkBodyForElbowPose: @escaping JointsChecker,
                checkBodyForStraitPose: @escaping JointsChecker) {
        self.checkStraitPoseHands = checkStraitPoseHands
        self.checkElbowPoseHands = checkElbowPoseHands
        self.checkBodyForElbowPose = checkBodyForElbowPose
        self.checkBodyForStraitPose = checkBodyForStraitPose
    }

    public func estimatePoseJoints(
        joints: [PoseJoint.Name: PoseJoint],
        imageSize: CGSize
    ) -> [PoseJoint.Name: PoseJoint] {
        var poseType: PlankPoseType = .undefined

        let acceptedValue = calculateAcceptedVariations(joints: joints,
                                                      imageSize: imageSize)

        if checkStraitPoseHands(joints, acceptedValue) {
            poseType = .straitHands
        } else if checkElbowPoseHands(joints, acceptedValue) {
            poseType = .elbow
        }

        guard poseType != .undefined else { return joints }

        checkBack(joints: joints, poseType: poseType, acceptedValue: acceptedValue)

        return joints
    }

    private func checkBack(joints: [PoseJoint.Name: PoseJoint],
                          poseType: PlankPoseType,
                          acceptedValue: CGFloat) {
        switch poseType {
        case .elbow:
            checkBodyForElbowPose(joints, acceptedValue)
        case .straitHands:
            checkBodyForStraitPose(joints, acceptedValue)
        case .undefined:
            return
        }
    }

    private func calculateAcceptedVariations(
        joints: [PoseJoint.Name: PoseJoint],
        imageSize: CGSize
    ) -> CGFloat {
        guard let legPoint = joints[.leftAnkle]?.position ?? joints[.rightAnkle]?.position,
              let neckPoint = joints[.neck]?.position else { return 3 * imageSize.width / 100 }

        let distance = abs(legPoint.x - neckPoint.x)
        return 3 * distance / 100
    }
}
