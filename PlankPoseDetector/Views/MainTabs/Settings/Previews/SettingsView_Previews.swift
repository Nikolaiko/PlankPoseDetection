//
//  SettingsView_Previews.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 18.05.2023.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct SettingsViewPreview: PreviewProvider {
    static var previews: some View {
        GeometryReader { geom in
            VStack(alignment: .center) {
                SettingsView(
                    stateStore: Store(
                        initialState: SettingsFeature.State(),
                        reducer: SettingsFeature()
                    )
                )
            }
            .frame(width: geom.size.width, height: geom.size.height)
        }
    }
}
