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

    init(stateStore: StoreOf<CameraFeature>) {
        self.stateStore = stateStore
    }

    var body: some View {
        WithViewStore(stateStore) { viewStore in
            FrameView(image: viewStore.currentFrame)
                .onAppear {
                    viewStore.send(.checkPermissions)
                }
        }
    }
}

//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}
