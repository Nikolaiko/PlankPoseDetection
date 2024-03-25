//
//  MainView_Preview.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(stateStore: Store(
            initialState: AppFeature.State(),
            reducer: { AppFeature() })
        )
    }
}
