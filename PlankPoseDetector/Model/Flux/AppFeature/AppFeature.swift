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
        @BindableState var selectedTabId: MainViewTabEnum

        var workoutState: WorkoutFeature.State? = nil
        var settingsState: SettingsFeature.State? = nil

        init(selectedTabId: MainViewTabEnum) {
            self.selectedTabId = selectedTabId
            switch self.selectedTabId {
            case .settings, .camera:
                settingsState = SettingsFeature.State()
            case .workout, .home:
                workoutState = WorkoutFeature.State()
            }
        }
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
                state.selectedTabId = tabType
                return changeTabHandler(into: &state)
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

    private func changeTabHandler(into state: inout State) -> Effect<Action, Never> {
        state.settingsState = nil
        state.workoutState = nil

        switch state.selectedTabId {
        case .settings, .camera:
            state.settingsState = SettingsFeature.State()
        case .workout, .home:
            state.workoutState = WorkoutFeature.State()
        default:
            print("Something")
        }
        return .none
    }
}

