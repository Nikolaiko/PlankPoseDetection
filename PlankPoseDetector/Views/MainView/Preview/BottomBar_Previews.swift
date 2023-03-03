//
//  BottomBarPreviews.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 29.01.2023.
//

import Foundation
import SwiftUI

struct AppBottomBar_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                AppBottomBar(
                    geometry: geometry,
                    selectedTabId: .constant(.statistics)
                )
            }
        }
    }
}
