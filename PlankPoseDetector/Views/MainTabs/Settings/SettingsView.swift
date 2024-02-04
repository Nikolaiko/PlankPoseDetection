//
//  SettingsView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import SwiftUI
import ComposableArchitecture

struct SettingsView: View {
    let stateStore: StoreOf<SettingsFeature>

    var body: some View {
        WithViewStore(stateStore, observe: { $0 }) { viewState in
            VStack {
                HStack {
                    Text(SettingsViewStrings.removeDataTitle)
                    Button {
                        viewState.send(.showDeleteAlert)
                    } label: {
                        Text(SettingsViewStrings.clearTitle)
                    }

                }
                Spacer()
            }
            .alert(isPresented: viewState.binding(get: \.deleteAlertShown, send: .hideDeleteAlert)) {
                Alert(
                    title: Text(SettingsViewStrings.removeDataAlertTitle),
                    primaryButton: .destructive(Text(SettingsViewStrings.deleteTitle), action: {
                        viewState.send(.deleteImportedVideos)
                    }),
                    secondaryButton: .cancel(Text(SettingsViewStrings.cancelTitle), action: {})
                )
            }.padding()
        }
    }
}
