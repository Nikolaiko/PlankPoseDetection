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
import PoseDetection

struct GalleryFeature: Reducer {
    struct State: Equatable {
        var activePlayer: AVPlayer?
        var bodyFrame: CGImage?
        var savedFilesList: [SavedVideoFile] = []

        var loadingVideo = false
        var processingImage = false
        var loadingFilesList = false
    }

    enum Action {
        case startLoadingFilesList
        case loadingFilesListResult([SavedVideoFile])

        case startLoadingVideoFromGallery
        case loadedVideoDataFromGallery(Data)
        case saveDataToTempFolderResult(URL?)

        case processFrame(CGImage?)
        case processFrameResult(UIImage)

        case togglePlayerState
        case backToGallery

        case prepareToClose(MainViewTabEnum)
        case readyToClose(MainViewTabEnum)
    }

    @Dependency(\.appAvPlayer) var appAvPlayer: GalleryVideoPlayer
    @Dependency(\.appFileManagerPlayer) var appFileManager: AppFileManager
    @Dependency(\.poseDetector) var detector: PoseDetector
    @Dependency(\.paintService) var painter: DrawImageService
    @Dependency(\.poseEstimation) var poseEstimation: PoseEstimationService

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .startLoadingFilesList:
            state.loadingFilesList = true
            return Effect.run { send in
                await send(.loadingFilesListResult(appFileManager.getSavedFiles()))
            }
        case .loadingFilesListResult(let loadedFiles):
            state.loadingFilesList = false
            state.savedFilesList = loadedFiles
            return .none
        case .startLoadingVideoFromGallery:
            state.loadingVideo = true
            return .none
        case .loadedVideoDataFromGallery(let videoData):
            return Effect.run { send in
                await send(.saveDataToTempFolderResult(appFileManager.loadDataFromUrl(videoData: videoData)))
            }
        case .saveDataToTempFolderResult(let urlResult):
            state.loadingVideo = false
            if let fileUrl = urlResult {
                state.activePlayer = appAvPlayer.player
                appAvPlayer.loadItemFromUrl(fileUrl: fileUrl)
                appAvPlayer.play()
                return Effect.run { send in
                    for await currentFrame in appAvPlayer.framesStream! {
                        await send(.processFrame(currentFrame))
                    }
                }
            } else {
                print("Failed to save file to directory")
                return .none
            }
        case .processFrame(let image):
            if let currentImage = image, state.processingImage == false {
                state.processingImage = true
                return Effect.run { send in
                    let uiImage = UIImage(cgImage: currentImage)
                    let points = detector.detectPoseOnImage(image: uiImage)
                    let estimated = poseEstimation.estimatePoseJoints(joints: points, imageSize: uiImage.size)
                    let resultImage = painter.drawPointsOnTransparentImage(sourceImage: uiImage, points: estimated)
                    await send(.processFrameResult(resultImage))
                }
            } else {
                return .none
            }
        case .processFrameResult(let imageResult):
            if appAvPlayer.isPlaying() {
                state.bodyFrame = imageResult.cgImage
            }
            state.processingImage = false
            return .none
        case .togglePlayerState:
            appAvPlayer.isPlaying()
                ? appAvPlayer.stop()
                : appAvPlayer.play()
            return .none
        case .backToGallery:
            appAvPlayer.stop()
            state.bodyFrame = nil
            return Effect.send(.startLoadingFilesList)
        case .prepareToClose(let newTabId):
            appAvPlayer.stop()
            return Effect.send(.readyToClose(newTabId))
        default:
            return .none
        }
    }
}
