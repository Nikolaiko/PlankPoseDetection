//
//  BottomBarIcon_Previews.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 29.01.2023.
//

import Foundation
import SwiftUI

struct BottomBarIconSelected_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarIcon(
            imageSide: 24,
            iconType: MainViewTabEnum.workout,
            selected: true
        )
    }
}

struct BottomBarIconUnSelected_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarIcon(
            imageSide: 24,
            iconType: MainViewTabEnum.workout,
            selected: false
        )
    }
}
