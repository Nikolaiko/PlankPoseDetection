import Foundation
import Dependencies
import Vision

public struct PoseDetector {

    public let detectPoses: PoseDetection

    public init(detectPoses: @escaping PoseDetection) {
        self.detectPoses = detectPoses
    }    
}
