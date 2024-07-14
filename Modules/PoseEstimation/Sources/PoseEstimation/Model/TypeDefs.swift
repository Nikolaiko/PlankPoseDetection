import Foundation
import CommonModels

public typealias JointsEstimation = ([PoseJoint.Name: PoseJoint],
                                     CGSize) -> [PoseJoint.Name: PoseJoint]

public typealias JointsValidator = ([PoseJoint.Name: PoseJoint], CGFloat) -> Bool

public typealias JointsChecker = ([PoseJoint.Name: PoseJoint], CGFloat) -> Void
