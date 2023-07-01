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
        GeometryReader { geom in
            if viewModel.currentErrorMessage != nil {
                showErrorMessage(geometry: geom)
            }
        }
        .background(Color.clear)
    }

    private func showErrorMessage(geometry: GeometryProxy) -> some View {
        VStack(alignment: .center) {
            Spacer()
            HStack {
                Spacer()
                Text(viewModel.currentErrorMessage?.message ?? "")
                    .padding(.vertical, 15)
                Spacer()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12.0)
                    .stroke(Color.black, lineWidth: 1)
            )
            .padding(.horizontal, geometry.size.width * 0.10)
            .padding(.bottom, geometry.size.height * 0.10)
        }
    }
    
}
