//
//  WorkoutView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import SwiftUI
import ComposableArchitecture
import AVKit

struct WorkoutView: View {
    let stateStore: StoreOf<WorkoutFeature>

    var body: some View {
        WithViewStore(stateStore) { viewState in
            ZStack {
                VStack {
                    ZStack {
                        VideoPlayer(player: viewState.player)
                        if viewState.resultImage != nil {
                            Image(uiImage: viewState.resultImage!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }

                    Button {
                        viewState.send(.processImage)
                    } label: {
                        Text("Test Vision")
                    }
                    Button {
                        viewState.send(.startPlayback)
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { currentTimer in
                            viewState.send(.getFrame)
                        })
                    } label: {
                        Text("Get Frame")
                    }
                }
                if viewState.isProcessing {
                    ProgressView()
                }
            }
        }
    }
}


/*
 Image(uiImage: viewState.resultImage != nil
       ? viewState.resultImage!
       : viewState.sourceImage
 )
 .resizable()
 .aspectRatio(contentMode: .fit)
 */
