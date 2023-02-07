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
        var cameraState: CameraPlaybackFeature.State? = nil

        init(selectedTabId: MainViewTabEnum) {
            self.selectedTabId = selectedTabId
            switch self.selectedTabId {
            case .settings:
                settingsState = SettingsFeature.State()
            case .workout, .home:
                workoutState = WorkoutFeature.State()
            case .camera:
                cameraState = CameraPlaybackFeature.State()
            }
        }
    }

    enum Action {
        case changeTab(MainViewTabEnum)
        case settingsActions(SettingsFeature.Action)
        case workoutActions(WorkoutFeature.Action)
        case cameraActions(CameraPlaybackFeature.Action)
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
        .ifLet(\.cameraState, action: /Action.cameraActions) {
            CameraPlaybackFeature()
        }
    }

    private func changeTabHandler(into state: inout State) -> Effect<Action, Never> {
        state.settingsState = nil
        state.workoutState = nil
        state.cameraState = nil

        switch state.selectedTabId {
        case .camera:
            state.cameraState = CameraPlaybackFeature.State()
        case .settings:
            state.settingsState = SettingsFeature.State()
        case .workout, .home:
            state.workoutState = WorkoutFeature.State()
        default:
            print("Something")
        }
        return .none
    }
}

