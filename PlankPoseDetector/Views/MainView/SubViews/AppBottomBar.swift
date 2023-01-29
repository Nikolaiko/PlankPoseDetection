//
//  AppBottomBar.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 28.01.2023.
//

import SwiftUI

struct AppBottomBar: View {
    var geometry: GeometryProxy
    var iconsSide: CGFloat { geometry.size.width * BottomBarCofficient.iconSide }

    @Binding var selectedTabId: MainViewTabEnum

    var body: some View {
        HStack {
            BottomBarIcon(imageSide: iconsSide, iconType: .home, selected: selectedTabId == .home)
                .padding(
                    .trailing,
                    geometry.size.width * BottomBarCofficient.iconsHorizontalPadding
                )
                .onTapGesture { selectedTabId = .home }

            BottomBarIcon(imageSide: iconsSide, iconType: .workout, selected: selectedTabId == .workout)
                .onTapGesture { selectedTabId = .workout }

            Spacer()

            BottomBarIcon(imageSide: iconsSide, iconType: .camera, selected: selectedTabId == .camera)
                .onTapGesture { selectedTabId = .camera }
            
            BottomBarIcon(imageSide: iconsSide, iconType: .settings, selected: selectedTabId == .settings)
                .padding(
                    .leading,
                    geometry.size.width * BottomBarCofficient.iconsHorizontalPadding
                )
                .onTapGesture { selectedTabId = .settings }
        }
        .padding(
            .horizontal,
            geometry.size.width * BottomBarCofficient.horizontalPadding
        )
        .padding(
            .vertical,
            geometry.size.height * BottomBarCofficient.verticalPadding
        )
    }
}
