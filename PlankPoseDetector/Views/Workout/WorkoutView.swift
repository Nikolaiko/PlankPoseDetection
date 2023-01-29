//
//  WorkoutView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import SwiftUI
import ComposableArchitecture

struct WorkoutView: View {
    let stateStore: StoreOf<WorkoutFeature>

    var body: some View {
        WithViewStore(stateStore) { viewState in
            ZStack {
                VStack {
                    Image(uiImage: viewState.resultImage != nil
                          ? viewState.resultImage!
                          : viewState.sourceImage
                    )
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    Button {
                        let _ = print("click")
                        viewState.send(.processImage)
                    } label: {
                        Text("Test Vision")
                    }
                }
                if viewState.isProcessing {
                    ProgressView()
                }
            }

        }
    }
}

//struct WorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutView()
//    }
//}
