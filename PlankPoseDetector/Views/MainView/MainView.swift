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
                    switch stateStore.selectedTabId {
                    case .home:
                        if let store = stateStore.scope(state: \.homeState, action: \.homeAction) {
                            //HomeView(stateStore: store)
                            EmptyView()
                        }
                    case .statistics:
                        if let store = stateStore.scope(state: \.statsState, action: \.statisticsAction) {
                            //StatisticsView(stateStore: store)
                            EmptyView()
                        }
                    case .gallery:
                        if let store = stateStore.scope(state: \.galleryState, action: \.galleryAction) {
                            //GalleryView(stateStore: store)
                            EmptyView()
                        }
                    case .settings:
                        if let store = stateStore.scope(state: \.settingsState, action: \.settingsAction) {
                            //SettingsView(stateStore: store)
                            EmptyView()
                        }
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
