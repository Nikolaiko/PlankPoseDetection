//
//  PoseView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 11.02.2023.
//

import SwiftUI
import ComposableArchitecture

struct PoseView: View {

    let stateStore: StoreOf<PoseDrawingFeature>

    var body: some View {
        WithViewStore(stateStore, observe: { $0 }) { viewStore in
            FrameView(image: viewStore.currentFrame?.cgImage)
        }
    }
}
