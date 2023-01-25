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
            VStack {
                Spacer()
                Text("Workout")
                Button {
                    let _ = print("click")
                    viewState.send(.processImage)
                } label: {
                    Text("Test Vision")
                }

                Spacer()

            }
        }
    }
}

//struct WorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutView()
//    }
//}
