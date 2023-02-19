//
//  PoseDrawingState.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 08.02.2023.
//

import Foundation
import UIKit
import ComposableArchitecture

struct PoseDrawingFeature: ReducerProtocol {

    @Dependency(\.poseDetector) var detector: PoseDetector
    @Dependency(\.paintService) var painter: DrawImageService

    struct State: Equatable {
        var currentFrame: UIImage?
        var processingFrame = false
        var frameCount = framesPerPoseDraw
    }

    enum Action {
        case frameFromParent(CGImage?)
        case processImageResult(UIImage?)
    }

    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
        switch action {
        case .frameFromParent(let image):
            if let currentImage = image, state.processingFrame == false {
                state.processingFrame = true
                return .task {
                    let uiImage = UIImage(cgImage: currentImage)
                    let points = detector.detectPoseOnImage(image: uiImage)
                    let resultImage = painter.drawPointsOnTransparentImage(sourceImage: uiImage, points: points)
                    return .processImageResult(resultImage)
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
