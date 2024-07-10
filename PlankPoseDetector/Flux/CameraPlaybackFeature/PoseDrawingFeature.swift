import Foundation
import UIKit
import ComposableArchitecture
import PoseDetection
import DrawPoseJoint

struct PoseDrawingFeature: Reducer {

    @Dependency(\.poseDetector) var detector: PoseDetector
    @Dependency(\.paintService) var painter: DrawPoseJoint

    struct State: Equatable {
        var currentFrame: UIImage?
        var processingFrame = false
    }

    enum Action {
        case frameFromParent(CGImage?)
        case processImageResult(UIImage?)
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .frameFromParent(let image):
            if let currentImage = image, state.processingFrame == false {
                state.processingFrame = true
                return Effect.run { send in
                    let uiImage = UIImage(cgImage: currentImage)
                    let points = detector.detectPoses(currentImage)
                    let resultImage = painter.drawPointsOnTransparentImage(uiImage,points)
                    await send(.processImageResult(resultImage))
                }
            } else {
                return .none
            }
        case .processImageResult(let newFrame):
            state.currentFrame = newFrame
            state.processingFrame = false
            return .none
        }
    }
}
