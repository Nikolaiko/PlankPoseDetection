//
//  SettingsFeature.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import Foundation
import ComposableArchitecture

struct SettingsFeature: ReducerProtocol {
    struct State: Equatable {

    }

    enum Action {
        case prepareToClose(MainViewTabEnum)
        case readyToClose(MainViewTabEnum)
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
        switch action {
        case .prepareToClose(let newTabId):
            return Effect(value: .readyToClose(newTabId))
        default:
            return .none
        }
    }
}
