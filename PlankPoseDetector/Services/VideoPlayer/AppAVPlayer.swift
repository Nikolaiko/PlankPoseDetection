//
//  AppAVPlayer.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 21.02.2023.
//

import Foundation
import AVFoundation

class AppAVPlayer: GalleryVideoPlayer {
    var framesStream: AsyncStream<CGImage?>?
    let player: AVPlayer = AVPlayer()
    
    private let fileManager = FileManager.default

    private var imageGenerator: AVAssetImageGenerator?
    private var timer = RepeatingTimer(timeInterval: 0.01)

    func loadDataFromUrl(videoData: Data) -> Bool {
        let tempDirPath = fileManager.temporaryDirectory
        let url = tempDirPath.appending(path: "videfile.mp4")
        var result = true

        do {
            try videoData.write(to: url)
            let item = AVPlayerItem(url: url)

            player.replaceCurrentItem(with: item)

            imageGenerator = AVAssetImageGenerator(asset: player.currentItem!.asset)
            imageGenerator?.appliesPreferredTrackTransform = true
        } catch {
            result = false
            print("Error during save temp file: \(error)")
        }
        return result
    }

    func play() {
        framesStream = AsyncStream { [weak self] continuation in
            continuation.onTermination = { termination in                
                continuation.finish()
            }

            self?.timer.eventHandler = {
                let snapshot = try? self?.imageGenerator?.copyCGImage(
                    at: self?.player.currentTime() ?? CMTime.zero,
                    actualTime: nil
                )
                continuation.yield(snapshot)
            }
            self?.timer.resume()
            self?.player.play()            
        }
    }

    func stop() {
        timer.suspend()
        player.pause()
    }
}
