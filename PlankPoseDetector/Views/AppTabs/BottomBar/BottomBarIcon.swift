//
//  BottomBarIcon.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 28.01.2023.
//

import SwiftUI

struct BottomBarIcon: View {
    let imageSide: CGFloat
    let iconType: MainViewTabEnum
    var selected: Bool

    var body: some View {
        VStack(spacing: 0) {
            Image(iconType.getImageName(isSelected: selected))
                .padding(.bottom, 6)
            Circle()
                .fill(selected ? BottomBarColors.selectedGradient : BottomBarColors.unselectedGradient)
                .frame(width: imageSide * 0.1666)

        }
    }
}
