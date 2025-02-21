import Foundation
import UIKit
import AVFoundation
import ComposableArchitecture
import PoseDetection
import AppVideoPlayer
import AppFilesManager
import DrawPoseJoint
import PoseEstimation

@Reducer
public struct GalleryTab {

    public init() { }

    @ObservableState
    public struct State: Equatable {
        public var activePlayer: AVPlayer?
        public var bodyFrame: CGImage?
        public var savedFilesList: [SavedVideoFile]

        public var loadingVideo: Bool
        public var processingImage: Bool
        public var loadingFilesList: Bool

        public init(activePlayer: AVPlayer? = nil,
                    bodyFrame: CGImage? = nil,
                    savedFilesList: [SavedVideoFile] = [],
                    loadingVideo: Bool = false,
                    processingImage: Bool = false,
                    loadingFilesList: Bool = false
        ) {
            self.activePlayer = activePlayer
            self.bodyFrame = bodyFrame
            self.savedFilesList = savedFilesList
            self.loadingVideo = loadingVideo
            self.processingImage = processingImage
            self.loadingFilesList = loadingFilesList
        }
    }

    public enum Action {
        case startLoadingFilesList
        case loadingFilesListResult([SavedVideoFile])

        case startLoadingVideoFromGallery
        case loadedVideoDataFromGallery(Data)
        case saveDataToTempFolderResult(URL?)

        case processFrame(CGImage?) 
        case processFrameResult(UIImage)

        case togglePlayerState
        case backToGallery
    }

    @Dependency(\.videoPlayer) var appAvPlayer: AppVideoPlayer

    //var appAvPlayer: AppAVPlayer = AppAVPlayer()
    @Dependency(\.fileManager) var appFileManager: AppFilesManager
    @Dependency(\.poseDetector) var detector: PoseDetector
    @Dependency(\.paintService) var painter: DrawPoseJoint
    @Dependency(\.poseEstimation) var poseEstimation: PoseEstimationService

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
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
                    let data = appFileManager.loadDataFromUrl(videoData)
                    await send(.saveDataToTempFolderResult(data))
                }
            case .saveDataToTempFolderResult(let urlResult):
                state.loadingVideo = false
                if let fileUrl = urlResult {
                    state.activePlayer = appAvPlayer.playerInstance()
                    //state.activePlayer = appAvPlayer.player
                    //appAvPlayer.loadItemFromUrl(fileUrl: fileUrl)
                    appAvPlayer.loadItemFromUrl(fileUrl)
                    appAvPlayer.play()
                    return Effect.run { send in
                        for await currentFrame in appAvPlayer.streamInstance()! {
                            await send(.processFrame(currentFrame))
                        }
                    }
                } else {
                    print("Failed to save file to directory")
                    return .none
                }
            case .processFrame(let image):
                print("processFrame: \(image), inProgress: \(state.processingImage)")
                if let currentImage = image, state.processingImage == false {
                    state.processingImage = true
                    return Effect.run { send in
                        let uiImage = UIImage(cgImage: currentImage)
                        let points = detector.detectPoses(currentImage)
                        let estimated = poseEstimation.estimatePoseJoints(joints: points, imageSize: uiImage.size)
                        let resultImage = painter.drawPointsOnTransparentImage(uiImage,
                                                                              estimated)
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
            }
        }
    }
}
