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
        VStack {
            Spacer()
            Text("Settings View")
            Spacer()
        }
    }
}
