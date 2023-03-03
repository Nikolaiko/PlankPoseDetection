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

    func loadDataFromUrl(videoData: Data) -> Bool
    func play()
    func stop()
}
