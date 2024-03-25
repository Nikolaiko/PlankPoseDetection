//
//  HomeView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 21.02.2023.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let stateStore: StoreOf<HomeFeature>

    var body: some View {
        VStack {
            let _ = print("Home")
            Text("Home View")
        }
        .background(Color.red)
    }
}
