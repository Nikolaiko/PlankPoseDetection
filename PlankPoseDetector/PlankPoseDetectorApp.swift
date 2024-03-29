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
    @UIApplicationDelegateAdaptor var delegate: PlankAppDelegate

    var body: some Scene {
        WindowGroup {
            MainView(stateStore: Store(initialState: AppFeature.State(),
                                       reducer: { AppFeature() }))
        }
    }
}
