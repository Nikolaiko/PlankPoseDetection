import Foundation
import Vision
import CommonModels

public typealias PoseDetection = (CGImage) -> [PoseJoint.Name: PoseJoint]
