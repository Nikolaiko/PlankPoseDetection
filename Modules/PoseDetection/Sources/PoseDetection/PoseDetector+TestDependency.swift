import Foundation
import Dependencies
import CommonModels

extension PoseDetector: TestDependencyKey {
    public static var testValue = Self(
        detectPoses: { _ in [:] }
    )

    public static var previewValue = Self(
        detectPoses: { _ in
            [
                PoseJoint.Name.root: PoseJoint(name: .root),
                PoseJoint.Name.neck: PoseJoint(name: .neck),

                PoseJoint.Name.leftShoulder: PoseJoint(name: .leftShoulder),
                PoseJoint.Name.rightShoulder: PoseJoint(name: .rightShoulder),

                PoseJoint.Name.leftElbow: PoseJoint(name: .leftElbow),
                PoseJoint.Name.rightElbow: PoseJoint(name: .rightElbow),

                PoseJoint.Name.leftWrist: PoseJoint(name: .leftWrist),
                PoseJoint.Name.rightWrist: PoseJoint(name: .rightWrist),

                PoseJoint.Name.leftHip: PoseJoint(name: .leftHip),
                PoseJoint.Name.rightHip: PoseJoint(name: .rightHip),

                PoseJoint.Name.leftKnee: PoseJoint(name: .leftKnee),
                PoseJoint.Name.rightKnee: PoseJoint(name: .rightKnee),

                PoseJoint.Name.leftAnkle: PoseJoint(name: .leftAnkle),
                PoseJoint.Name.rightAnkle: PoseJoint(name: .rightAnkle)
            ]
        }
    )
}
