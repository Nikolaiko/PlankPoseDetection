//
//  CameraView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 08.02.2023.
//

import SwiftUI
import ComposableArchitecture

struct CameraView: View {
    let stateStore: StoreOf<CameraFeature>

    var body: some View {
        WithViewStore(stateStore) { viewStore in
            FrameView(image: nil)
                .onAppear {
                    viewStore.send(.prepare)
                }
        }
    }
}

//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}
