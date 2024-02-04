//
//  WorkoutView_Previews.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 01.02.2023.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(
            stateStore: Store(
                initialState: WorkoutFeature.State(),
                reducer: { WorkoutFeature() }
            )
        )
    }
}
