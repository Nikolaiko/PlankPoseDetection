//
//  CameraPlaybackView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 08.02.2023.
//

import SwiftUI
import ComposableArchitecture

struct CameraPlaybackView: View {
    let stateStore: StoreOf<CameraPlaybackFeature>

    var body: some View {
        ZStack {
            IfLetStore(
                stateStore.scope(
                    state: \.cameraState,
                    action: CameraPlaybackFeature.Action.cameraAction
                )
            ) { cameraStore in
                CameraView(stateStore: cameraStore)
            }
            IfLetStore(
                stateStore.scope(
                    state: \.drawingState,
                    action: CameraPlaybackFeature.Action.poseDrawingAction
                )
            ) { drawingStore in
                PoseView(stateStore: drawingStore)
            }
        }
    }
}
