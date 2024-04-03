//
//  VideoPlayerOverlay_Preview.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 13.05.2023.
//

import Foundation
import SwiftUI

struct VideoPlayerOverlayPlayingPreview: PreviewProvider {
    static var previews: some View {
        GeometryReader { geom in
            VideoPlayerOverlay(
                isPlaying: true,
                geometry: geom,
                onBackButton: nil,
                onPlayPause: nil
            )
        }
    }
}

struct VideoPlayerOverlayPausePreview: PreviewProvider {
    static var previews: some View {
        GeometryReader { geom in
            VideoPlayerOverlay(
                isPlaying: false,
                geometry: geom,
                onBackButton: nil,
                onPlayPause: nil
            )
        }
    }
}
