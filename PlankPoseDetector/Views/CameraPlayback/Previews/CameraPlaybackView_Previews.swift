//
//  CameraPlaybackView_Previews.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 11.03.2023.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct PoseViewInitialPreviews: PreviewProvider {
    static var previews: some View {
        PoseView(
            stateStore: Store(
                initialState: PoseDrawingFeature.State(),
                reducer: PoseDrawingFeature()
            )
        )
    }
}

struct PoseViewDrawPosePreviews: PreviewProvider {
    static var previews: some View {
        let url = Bundle.main.url(forResource: "PosePreviewImage", withExtension: "jpg")
        let fileData: Data? = try? Data(contentsOf: url!)
        let image = fileData == nil ? nil : UIImage(data: fileData!)
        let initialState = PoseDrawingFeature.State(
            currentFrame: image,
            processingFrame: false
        )
        PoseView(
            stateStore: Store(
                initialState: initialState,
                reducer: PoseDrawingFeature()
            )
        )
    }
}
