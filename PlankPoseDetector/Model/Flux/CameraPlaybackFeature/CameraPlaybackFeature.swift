//
//  CameraPlaybackFeature.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 08.02.2023.
//

import Foundation
import ComposableArchitecture

struct CameraPlaybackFeature: ReducerProtocol {

    struct State: Equatable {
        var cameraState: CameraFeature.State? = CameraFeature.State()
        var drawingState: PoseDrawingFeature.State? = PoseDrawingFeature.State()
    }

    enum Action {
        case cameraAction(CameraFeature.Action)
        case poseDrawingAction(PoseDrawingFeature.Action)
    }

    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
        .ifLet(\.cameraState, action: /Action.cameraAction) {
            CameraFeature()
        }
        .ifLet(\.drawingState, action: /Action.poseDrawingAction) {
            PoseDrawingFeature()
        }
    }

}
