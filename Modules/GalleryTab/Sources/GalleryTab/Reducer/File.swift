//
//  File.swift
//  VideoPlayer
//
//  Created by Nikolai Baklanov on 03.10.2024.
//

import Foundation
import AVFoundation
import AppVideoPlayer

class AppAVPlayer: GalleryVideoPlayer {
    var framesStream: AsyncStream<CGImage?>?
    let player: AVPlayer = AVPlayer()

    private var imageGenerator: AVAssetImageGenerator?
    private var timer = RepeatingTimer(timeInterval: 0.01)

    func loadItemFromUrl(fileUrl: URL) {
        let item = AVPlayerItem(url: fileUrl)

        player.replaceCurrentItem(with: item)

        imageGenerator = AVAssetImageGenerator(asset: player.currentItem!.asset)
        imageGenerator?.appliesPreferredTrackTransform = true
    }

    func isPlaying() -> Bool {
        return player.isPlaying()
    }

    func play() {
        if framesStream == nil {
            initAsyncStream()
        }
        timer.resume()
        player.play()
    }

    func stop() {
        timer.suspend()
        player.pause()
    }

    private func initAsyncStream() {
        framesStream = AsyncStream { [weak self] continuation in
            continuation.onTermination = { _ in
                continuation.finish()
            }

            self?.timer.eventHandler = {
                print("Here!")
                let snapshot = try? self?.imageGenerator?.copyCGImage(
                    at: self?.player.currentTime() ?? CMTime.zero,
                    actualTime: nil
                )
                continuation.yield(snapshot)
            }
        }
    }
}

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

