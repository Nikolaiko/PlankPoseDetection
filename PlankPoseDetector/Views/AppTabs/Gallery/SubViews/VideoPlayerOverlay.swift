//
//  VideoPlayerOverlay.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 13.05.2023.
//

import SwiftUI

struct VideoPlayerOverlay: View {
    let isPlaying: Bool
    let geometry: GeometryProxy
    let onBackButton: VoidCallback?
    let onPlayPause: VoidCallback?

    var body: some View {
        VStack(spacing: 0) {
            Image(GalleryImageNames.playerCloseImageName)
                .frame(width: geometry.size.width * 0.1)
                .onTapGesture {
                    onBackButton?()
                }
                .padding(.top, 8)
            Spacer()
            Image(isPlaying ? GalleryImageNames.playerPauseImageName : GalleryImageNames.playerPlayImageName)
                .frame(width: geometry.size.width * 0.1)
                .onTapGesture {
                    onPlayPause?()
                }
                .padding(.bottom, 8)
        }
        .frame(width: geometry.size.width, height: geometry.size.height)
    }
}
