import Foundation
import SwiftUI
import CoreGraphics

final public class PoseJoint {
    public enum Name: String, CaseIterable {
        case nose
        case leftEye
        case rightEye
        case leftEar
        case rightEar
        case leftShoulder
        case rightShoulder
        case leftElbow
        case rightElbow
        case leftWrist
        case rightWrist
        case leftHip
        case rightHip
        case leftKnee
        case rightKnee
        case leftAnkle
        case rightAnkle
        case neck
        case root
    }

    public enum Validation: String {
        case unchecked
        case correct
        case wrong

        public var color: Color {
            switch self {
            case .correct:
                return .green
            case .wrong:
                return .red
            case .unchecked:
                return .orange
            }
        }
    }

    public let name: Name
    public var position: CGPoint
    public var confidence: Double
    public var validationStatus: Validation

    public init(
        name: Name,
        position: CGPoint = .zero,
        confidence: Double = 0,
        validationStatus: Validation = .unchecked
    ) {
        self.name = name
        self.position = position
        self.confidence = confidence
        self.validationStatus = validationStatus
    }
}
