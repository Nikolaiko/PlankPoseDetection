//
//  AlertView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 10.09.2023.
//

import SwiftUI

struct AlretViewExample: View {
    var alertMessage: String

    var body: some View {
        HStack {
            Spacer()
            Text(alertMessage)
                .font(.title)
                .foregroundColor(Color.white)
            Spacer()
        }
        .padding(.all, 16)
        .background(purpleLinearGradient)
    }
}
