//
//  MainView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let stateStore: StoreOf<AppFeature>

    var body: some View {
        WithViewStore(stateStore) { viewState in
            GeometryReader { geom in
                VStack {
                    IfLetStore(
                        stateStore.scope(
                            state: \.settingsState,
                            action: AppFeature.Action.settingsActions
                        )
                    ) { settingsStore in
                        SettingsView(stateStore: settingsStore)
                    }
                    IfLetStore(
                        stateStore.scope(
                            state: \.workoutState,
                            action: AppFeature.Action.workoutActions
                        )
                    ) { workoutStore in
                        WorkoutView(stateStore: workoutStore)
                    }
                    AppBottomBar(
                        geometry: geom,
                        selectedTabId: viewState.binding(
                            get: \.selectedTabId,
                            send: AppFeature.Action.changeTab
                        )
                    )
                }
            }
        }
    }
}
