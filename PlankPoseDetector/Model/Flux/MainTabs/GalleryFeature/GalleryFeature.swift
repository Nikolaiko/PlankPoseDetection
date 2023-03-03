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
    }

    enum Action {
        case loadedVideoData(Data)
        case prepareToClose(MainViewTabEnum)
        case readyToClose(MainViewTabEnum)
    }

    @Dependency(\.appAvPlayer) var appAvPlayer: GalleryVideoPlayer

    func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
        switch action {
        case .loadedVideoData(let videoData):
            if appAvPlayer.loadDataFromUrl(videoData: videoData) {
                state.activePlayer = appAvPlayer.player
                appAvPlayer.play()
            }
            return .none
        case .prepareToClose(let newTabId):
            appAvPlayer.stop()
            return Effect(value: .readyToClose(newTabId))
        default:
            return .none
        }
    }
}


