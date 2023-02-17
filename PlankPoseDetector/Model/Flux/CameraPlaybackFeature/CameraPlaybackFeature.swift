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
            case .cameraAction(let childAction):
                return processCameraAction(state: &state, action: childAction)
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

    private func processCameraAction(
        state: inout CameraPlaybackFeature.State,
        action: CameraFeature.Action
    ) -> Effect<CameraPlaybackFeature.Action, Never> {
        switch action {
        case .sendFrameToParent(let image):
            return Effect(value: CameraPlaybackFeature.Action.poseDrawingAction(.frameFromParent(image)))
        default:
            return .none
        }
    }

}
