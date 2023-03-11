//
//  StatisticsView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 21.02.2023.
//

import SwiftUI
import ComposableArchitecture

struct StatisticsView: View {
    let stateStore: StoreOf<StatisticsFeature>

    var body: some View {
        VStack {
            Spacer()
            Text("Statistics View")
            Spacer()
        }
    }
}
