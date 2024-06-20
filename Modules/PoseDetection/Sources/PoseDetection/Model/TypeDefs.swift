import Foundation
import Vision

public typealias PoseDetection = (CGImage) -> [PoseJoint.Name: PoseJoint]
