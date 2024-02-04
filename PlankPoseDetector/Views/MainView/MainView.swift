//
//  MainView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    @Perception.Bindable var stateStore: StoreOf<AppFeature>

    var body: some View {
        WithPerceptionTracking {
            GeometryReader { geom in
                VStack {
                    IfLetStore(
                        stateStore.scope(
                            state: \.settingsState,
                            action: AppFeature.Action.settingsAction
                        )
                    ) { settingsStore in
                        SettingsView(stateStore: settingsStore)
                    }
                    IfLetStore(
                        stateStore.scope(
                            state: \.statsState,
                            action: AppFeature.Action.statisticsAction
                        )
                    ) { statsStore in
                        StatisticsView(stateStore: statsStore)
                    }
                    IfLetStore(
                        stateStore.scope(
                            state: \.galleryState,
                            action: AppFeature.Action.galleryAction
                        )
                    ) { galleryStore in
                        GalleryView(stateStore: galleryStore)
                    }
                    IfLetStore(
                        stateStore.scope(
                            state: \.homeState,
                            action: AppFeature.Action.homeAction
                        )
                    ) { homeStore in
                        HomeView(stateStore: homeStore)
                    }
                    AppBottomBar(
                        geometry: geom,
                        selectedTabId: $stateStore.selectedTabId.sending(\.changeTab)
                    )
                }
            }
            .background(Color.white)
        }
    }
}
