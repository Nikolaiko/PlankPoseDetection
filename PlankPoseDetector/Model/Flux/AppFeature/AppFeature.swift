//
//  AppFeature.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import Foundation
import ComposableArchitecture

struct AppFeature: ReducerProtocol {

    struct State: Equatable {
        var workoutState: WorkoutFeature.State? = WorkoutFeature.State()
        var settingsState: SettingsFeature.State? = nil
    }

    enum Action {
        case changeTab(MainViewTabEnum)
        case settingsActions(SettingsFeature.Action)
        case workoutActions(WorkoutFeature.Action)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .changeTab(let tabType):
                return changeTabHandler(into: &state, tabType: tabType)
            default:
                return .none
            }
        }
        .ifLet(\.workoutState, action: /Action.workoutActions) {
            WorkoutFeature()
        }
        .ifLet(\.settingsState, action: /Action.settingsActions) {
            SettingsFeature()
        }
    }

    private func changeTabHandler(into state: inout State, tabType: MainViewTabEnum) -> Effect<Action, Never> {
        state.settingsState = nil
        state.workoutState = nil

        switch tabType {
        case .settings:
            state.settingsState = SettingsFeature.State()
        case .workout:
            state.workoutState = WorkoutFeature.State()
        }
        return .none
    }
}

