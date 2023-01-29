//
//  PlankPoseDetectorApp.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct PlankPoseDetectorApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(stateStore: Store(
                initialState: AppFeature.State(selectedTabId: .home),
                reducer: AppFeature()
            ))
        }
    }
}
