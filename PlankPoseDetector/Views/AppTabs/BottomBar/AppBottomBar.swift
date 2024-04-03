//
//  AppBottomBar.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 28.01.2023.
//

import SwiftUI
import ComposableArchitecture

struct AppBottomBar: View {
    var geometry: GeometryProxy
    var iconsSide: CGFloat { geometry.size.width * BottomBarCofficient.iconSide }

    var store: StoreOf<AuthorizedFeature>
    var currentTab: MainViewTabEnum { store.state.mainTabEnumValue }

    var body: some View {
        HStack {
            BottomBarIcon(imageSide: iconsSide, iconType: .home, selected: currentTab == .home)
                .padding(
                    .trailing,
                    geometry.size.width * BottomBarCofficient.iconsHorizontalPadding
                )
                .onTapGesture { store.send(.switchTab(.home)) }

            BottomBarIcon(imageSide: iconsSide, iconType: .statistics, selected: currentTab == .statistics)
                .onTapGesture { store.send(.switchTab(.statistics)) }

            Spacer()

            BottomBarIcon(imageSide: iconsSide, iconType: .gallery, selected: currentTab == .gallery)
                .onTapGesture { store.send(.switchTab(.gallery)) }

            BottomBarIcon(imageSide: iconsSide, iconType: .settings, selected: currentTab == .settings)
                .padding(
                    .leading,
                    geometry.size.width * BottomBarCofficient.iconsHorizontalPadding
                )
                .onTapGesture { store.send(.switchTab(.settings)) }
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
