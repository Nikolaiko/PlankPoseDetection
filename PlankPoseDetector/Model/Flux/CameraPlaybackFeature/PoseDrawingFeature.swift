//
//  PoseDrawingState.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 08.02.2023.
//

import Foundation
import ComposableArchitecture

struct PoseDrawingFeature: ReducerProtocol {
    
    struct State: Equatable {

    }

    enum Action {

    }

    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.EffectTask<Action> {
        return .none
    }
}
