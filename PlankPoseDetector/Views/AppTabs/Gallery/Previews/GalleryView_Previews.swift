//
//  GalleryView_Previews.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 18.03.2023.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct GalleryViewPreviews: PreviewProvider {
    static var previews: some View {
        GalleryView(
            stateStore: Store(
                initialState: GalleryFeature.State(),
                reducer: { GalleryFeature() }
            )
        )
    }
}
