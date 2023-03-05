//
//  GalleryFeature.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 21.02.2023.
//

import Foundation
import UIKit
import AVFoundation
import ComposableArchitecture


struct GalleryFeature: ReducerProtocol {
    struct State: Equatable {
        var activePlayer: AVPlayer?
        var bodyFrame: CGImage?

        var loadingVideo = false
        var processingImage = false
    }

    enum Action {
        case startLoadingVideoFromGallery
        case loadedVideoDataFromGallery(Data)
        case saveDataToTempFolderResult(Bool)
        case processFrame(CGImage?)
        case processFrameResult(UIImage)
        case prepareToClose(MainViewTabEnum)
        case readyToClose(MainViewTabEnum)
    }

    @Dependency(\.appAvPlayer) var appAvPlayer: GalleryVideoPlayer
    @Dependency(\.poseDetector) var detector: PoseDetector
    @Dependency(\.paintService) var painter: DrawImageService

    func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
        switch action {
        case .startLoadingVideoFromGallery:
            state.loadingVideo = true
            return .none
        case .loadedVideoDataFromGallery(let videoData):
            return .task {
                .saveDataToTempFolderResult(appAvPlayer.loadDataFromUrl(videoData: videoData))
            }
        case .saveDataToTempFolderResult(let success):
            state.loadingVideo = false
            if success {
                state.activePlayer = appAvPlayer.player
                appAvPlayer.play()
                return Effect.run { send in
                    for await currentFrame in appAvPlayer.framesStream! {
                        await send(.processFrame(currentFrame))
                    }
                }
            } else {
                return .none
            }
        case .processFrame(let image):
            if let currentImage = image, state.processingImage == false {
                state.processingImage = true
                return .task {
                    let uiImage = UIImage(cgImage: currentImage)
                    let points = detector.detectPoseOnImage(image: uiImage)
                    let resultImage = painter.drawPointsOnTransparentImage(sourceImage: uiImage, points: points)
                    return .processFrameResult(resultImage)
                }
            } else {
                return .none
            }
        case .processFrameResult(let imageResult):
            state.bodyFrame = imageResult.cgImage
            state.processingImage = false
            return .none
        case .prepareToClose(let newTabId):
            appAvPlayer.stop()
            return Effect(value: .readyToClose(newTabId))
        default:
            return .none
        }
    }
}


