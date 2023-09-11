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
        @BindingState var deleteAlertShown: Bool = false
    }

    enum Action {
        case deleteImportedVideos
        case showDeleteAlert
        case hideDeleteAlert
        case prepareToClose(MainViewTabEnum)
        case readyToClose(MainViewTabEnum)
        case binding(BindingAction<State>)
    }

    @Dependency(\.appFileManagerPlayer) var appFileManager: AppFileManager
    @Dependency(\.hudMessenger) var hudMessenger: HUDMessenger

    func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
        switch action {
        case .deleteImportedVideos:
            clearSavedFiles()
            return .none
        case .showDeleteAlert:
            state.deleteAlertShown = true
            return .none
        case .hideDeleteAlert:
            state.deleteAlertShown = false
            return .none
        case .prepareToClose(let newTabId):
            return Effect(value: .readyToClose(newTabId))
        case .binding:
            return .none
        default:
            return .none
        }
    }

    private func clearSavedFiles() {
        do {
            try appFileManager.removeSavedFiles()
            hudMessenger.sendMessage(
                message: HUDMessage(
                    message: SettingsViewStrings.clearingFilesComplete,
                    priority: .normal
                )
            )
        } catch {
            hudMessenger.sendMessage(
                message: HUDMessage(
                    message: SettingsViewStrings.errorDuringClearingFiles,
                    priority: .normal
                )
            )
        }
    }
}
