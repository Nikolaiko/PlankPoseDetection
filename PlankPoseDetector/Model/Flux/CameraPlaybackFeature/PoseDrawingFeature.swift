//
//  PoseDrawingState.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 08.02.2023.
//

import Foundation
import UIKit
import ComposableArchitecture
import PoseDetection

struct PoseDrawingFeature: Reducer {

    @Dependency(\.poseDetector) var detector: PoseDetector
    @Dependency(\.paintService) var painter: DrawImageService

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
                    let points = detector.detectPoseOnImage(image: uiImage)
                    let resultImage = painter.drawPointsOnTransparentImage(sourceImage: uiImage, points: points)
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
