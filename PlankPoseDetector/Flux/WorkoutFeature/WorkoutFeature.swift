//
//  WorkoutFeature.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import Foundation
import ComposableArchitecture
import UIKit
import Dependencies
import AVFoundation
import PoseDetection

struct WorkoutFeature: Reducer {

    struct State: Equatable {
        var sourceImage: UIImage
        var resultImage: UIImage?
        var isProcessing: Bool = false
        var player: AVPlayer
        var imageGenerator: AVAssetImageGenerator
        var timer: Timer?

        private var item: AVPlayerItem

        init() {
            let imageUrl = Bundle.main.url(forResource: "example", withExtension: "jpg")
            self.sourceImage = UIImage(contentsOfFile: imageUrl!.path)!

            let videoUrl = Bundle.main.url(forResource: "video", withExtension: "mp4")
            self.item = AVPlayerItem(url: videoUrl!)
            self.player = AVPlayer(playerItem: item)
            self.imageGenerator = AVAssetImageGenerator(asset: player.currentItem!.asset)
            self.imageGenerator.appliesPreferredTrackTransform = true
        }
    }

    enum Action {
        case processImage
        case processImageResult(UIImage?)

        case startPlayback
        case getFrame
    }

    @Dependency(\.poseDetector) var detector: PoseDetector
    @Dependency(\.paintService) var painter: DrawImageService

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .processImage:
            state.isProcessing = true
            let image = state.sourceImage
            return Effect.run { send in
                let points = detector.detectPoseOnImage(image: image)
                let resultImage = painter.drawPointsOnImage(sourceImage: image, points: points)
                await send(.processImageResult(resultImage))
            }
        case .processImageResult(let imageResult):
            if let res = imageResult {
                // state.resultImage = res
            } else {
                print("Failt")
            }
            state.isProcessing = false
            return .none

        case .startPlayback:
            if state.player.rate == 0 {
                state.player.play()
            }
            return .none
        case .getFrame:
            if state.player.rate != 0 {
                let currentTime = state.player.currentTime()
                let generator = state.imageGenerator
                return Effect.run { send in
                    var resultImage: UIImage?
                    if let snapshot = try? await generator.image(at: currentTime) {
                        let points = detector.detectPoseOnImage(image: UIImage(cgImage: snapshot.image))
                        resultImage = painter.drawPointsOnImage(
                            sourceImage: UIImage(cgImage: snapshot.image),
                            points: points
                        )
                    }
                    await send(.processImageResult(resultImage))                    
                }
            } else {
                return .none
            }
        }
    }
}
