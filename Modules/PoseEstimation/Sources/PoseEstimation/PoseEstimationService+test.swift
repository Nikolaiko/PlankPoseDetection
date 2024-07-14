import Foundation
import Dependencies

extension PoseEstimationService: TestDependencyKey {
    public static let testValue = Self { joints, acceptedValue in
        true
    } checkElbowPoseHands: { joints, acceptedValue in
        false
    } checkBodyForElbowPose: { joints, acceptedValue in

    } checkBodyForStraitPose: { joints, acceptedValue in

    }


    public static let previewValue = Self { joints, acceptedValue in
        true
    } checkElbowPoseHands: { joints, acceptedValue in
        false
    } checkBodyForElbowPose: { joints, acceptedValue in

    } checkBodyForStraitPose: { joints, acceptedValue in

    }
}
