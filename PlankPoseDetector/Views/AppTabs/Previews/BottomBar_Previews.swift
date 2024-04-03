//
//  BottomBarPreviews.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 29.01.2023.
//

import Foundation
import SwiftUI
import ComposableArchitecture

#Preview("AppTabs_HomeTab_Preview") {
    GeometryReader { geometry in
        VStack {
            Spacer()
            AppBottomBar(
                geometry: geometry,
                store: Store(
                    initialState: AuthorizedFeature.State.homeTab(HomeFeature.State()), reducer: {
                        AuthorizedFeature()
                    })
            )
        }
    }
}
