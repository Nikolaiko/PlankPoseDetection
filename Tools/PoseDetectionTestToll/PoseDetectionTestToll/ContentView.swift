//
//  ContentView.swift
//  PoseDetectionTestToll
//
//  Created by Nikolai Baklanov on 15.10.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = DetectViewModel()

    var body: some View {
        GeometryReader { geom in
            VStack {
                ZStack {
                    Image("image1")
                        .resizable()
                    if viewModel.result != nil {
                        Image(nsImage: viewModel.result!)
                            .resizable()
                    }
                }
                Button(action: { viewModel.detect() },
                       label: { Text("Detect") }
                )
            }
        }
    }
}
