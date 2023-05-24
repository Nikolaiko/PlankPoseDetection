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
                showErrorMessage()
            }
        }
        .background(Color.clear)
    }

    private func showErrorMessage() -> some View {
        VStack {
            Spacer()
            Text(viewModel.currentErrorMessage?.message ?? "")
        }
    }
}

struct HUDWindowView_Previews: PreviewProvider {
    static var previews: some View {
        HUDWindowView()
    }
}
