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
        @BindingState var selectedTabId: MainViewTabEnum

        var homeState: HomeFeature.State?
        var statsState: StatisticsFeature.State?
        var galleryState: GalleryFeature.State?
        var settingsState: SettingsFeature.State?

        init(selectedTabId: MainViewTabEnum) {
            self.selectedTabId = selectedTabId
            switch self.selectedTabId {
            case .settings:
                settingsState = SettingsFeature.State()
            case .statistics:
                statsState = StatisticsFeature.State()
            case .home:
                homeState = HomeFeature.State()
            case .gallery:
                galleryState = GalleryFeature.State()
            }
        }
    }

    enum Action {
        case changeTab(MainViewTabEnum)
        case settingsAction(SettingsFeature.Action)
        case homeAction(HomeFeature.Action)
        case galleryAction(GalleryFeature.Action)
        case statisticsAction(StatisticsFeature.Action)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .changeTab(let tabType):
                guard state.selectedTabId != tabType else { return .none }
                return prepareTabChange(into: &state, tabType: tabType)
            case .galleryAction(let childAction):
                return processGalleryActions(into: &state, childAction: childAction)
            case .settingsAction(let childAction):
                return processSettingsActions(into: &state, childAction: childAction)
            case .statisticsAction(let childAction):
                return processStatsActions(into: &state, childAction: childAction)
            case .homeAction(let childAction):
                return processHomeActions(into: &state, childAction: childAction)
            }
        }
        .ifLet(\.homeState, action: /Action.homeAction) {
            HomeFeature()
        }
        .ifLet(\.settingsState, action: /Action.settingsAction) {
            SettingsFeature()
        }
        .ifLet(\.statsState, action: /Action.statisticsAction) {
            StatisticsFeature()
        }
        .ifLet(\.galleryState, action: /Action.galleryAction) {
            GalleryFeature()
        }
    }

    private func processHomeActions(into state: inout State, childAction: HomeFeature.Action) -> Effect<Action, Never> {
        switch childAction {
        case .readyToClose(let newTabId):
            state.selectedTabId = newTabId
            return changeTabHandler(into: &state)
        default:
            return .none
        }
    }

    private func processStatsActions(
        into state: inout State,
        childAction: StatisticsFeature.Action
    ) -> Effect<Action, Never> {
        switch childAction {
        case .readyToClose(let newTabId):
            state.selectedTabId = newTabId
            return changeTabHandler(into: &state)
        default:
            return .none
        }
    }

    private func processSettingsActions(
        into state: inout State,
        childAction: SettingsFeature.Action
    ) -> Effect<Action, Never> {
        switch childAction {
        case .readyToClose(let newTabId):
            state.selectedTabId = newTabId
            return changeTabHandler(into: &state)
        default:
            return .none
        }
    }

    private func processGalleryActions(
        into state: inout State,
        childAction: GalleryFeature.Action
    ) -> Effect<Action, Never> {
        switch childAction {
        case .readyToClose(let newTabId):
            state.selectedTabId = newTabId
            return changeTabHandler(into: &state)
        default:
            return .none
        }
    }

    private func prepareTabChange(into state: inout State, tabType: MainViewTabEnum) -> Effect<Action, Never> {
        switch state.selectedTabId {
        case .gallery:
            return Effect(value: .galleryAction(.prepareToClose(tabType)))
        case .home:
            return Effect(value: .homeAction(.prepareToClose(tabType)))
        case .settings:
            return Effect(value: .settingsAction(.prepareToClose(tabType)))
        case .statistics:
            return Effect(value: .statisticsAction(.prepareToClose(tabType)))
        }
    }

    private func changeTabHandler(into state: inout State) -> Effect<Action, Never> {
        state.settingsState = nil
        state.galleryState = nil
        state.statsState = nil
        state.homeState = nil
        
        switch state.selectedTabId {
        case .gallery:
            state.galleryState = GalleryFeature.State()
            return .none
        case .settings:
            state.settingsState = SettingsFeature.State()
            return .none
        case .statistics:
            state.statsState = StatisticsFeature.State()
            return .none
        case .home:
            state.homeState = HomeFeature.State()
            return .none
        }
    }
}
