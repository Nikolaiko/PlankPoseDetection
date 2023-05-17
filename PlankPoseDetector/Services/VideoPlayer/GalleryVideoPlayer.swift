//
//  VideoPlayer.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 21.02.2023.
//

import Foundation
import UIKit
import AVFoundation

protocol GalleryVideoPlayer {

    var framesStream: AsyncStream<CGImage?>? { get }
    var player: AVPlayer { get }

    func isPlaying() -> Bool
    func loadItemFromUrl(fileUrl: URL)
    func play()
    func stop()
}
