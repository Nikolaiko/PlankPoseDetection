import Foundation

@testable import PoseDetection

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#endif

let testImageUrl = Bundle.module.url(forResource: "strait_hands_1", withExtension: "png")!
let testImageData = try? Data(contentsOf: testImageUrl)

#if os(macOS)
let testImage = NSImage(contentsOf: testImageUrl)!
var imageRect = CGRect(x: 0, y: 0, width: testImage.size.width, height: testImage.size.height)
let testCGImage = testImage.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)
#elseif os(iOS)
let testImage = UIImage(data: testImageData!)
let testCGImage = testImage?.cgImage
#endif

let testImageExpectedJointsCount = 14
let testImageExpectedTypes = [
    PoseJoint.Name.neck,
    PoseJoint.Name.rightHip,
    PoseJoint.Name.rightShoulder,
    PoseJoint.Name.rightElbow,
    PoseJoint.Name.leftWrist,
    PoseJoint.Name.leftKnee,
    PoseJoint.Name.root,
    PoseJoint.Name.rightAnkle,
    PoseJoint.Name.rightWrist,
    PoseJoint.Name.leftAnkle,
    PoseJoint.Name.leftElbow,
    PoseJoint.Name.leftHip,
    PoseJoint.Name.leftShoulder,
    PoseJoint.Name.rightKnee
]
