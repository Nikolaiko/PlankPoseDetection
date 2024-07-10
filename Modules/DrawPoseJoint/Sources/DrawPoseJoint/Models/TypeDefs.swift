import UIKit
import CommonModels

public typealias ImageDrawer = (UIImage, [PoseJoint.Name: PoseJoint]) -> UIImage

typealias DrawLineHelper = (CGContext, PoseJoint?, PoseJoint?) -> Void
