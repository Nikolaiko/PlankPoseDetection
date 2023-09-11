//
//  HUDWindowView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 20.05.2023.
//

import SwiftUI

struct HUDWindowView: View {
    @StateObject var viewModel = HUDViewModel()

    var body: some View {
        GeometryReader { _ in

        }
        .modifier(
            MessageBox(
                isPresented: $viewModel.isPresented,
                backGroundColor: .clear,
                messageAnimation: .default,
                messageType: .banner,
                view: {
                    AlretViewExample(alertMessage: viewModel.messages.first!.message)
                }
            )
        )
    }
}
