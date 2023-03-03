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
    private var timer: Timer?

    func loadDataFromUrl(videoData: Data) -> Bool {
        let tempDirPath = fileManager.temporaryDirectory
        let url = tempDirPath.appendingPathExtension("videfile.mp4")
        var result = true

        do {
            try videoData.write(to: url)
            let item = AVPlayerItem(url: url)

            player.replaceCurrentItem(with: item)

            imageGenerator = AVAssetImageGenerator(asset: player.currentItem!.asset)
            imageGenerator?.appliesPreferredTrackTransform = true
        } catch {
            result = false
            print("Error during save temp file")
        }
        return result
    }

    func play() {
//        framesStream = AsyncStream { [weak self] continuation in
//            continuation.onTermination = { [weak self] termination in
//                print("Terminating")
//                self?.timer?.invalidate()
//                self?.timer = nil
//                continuation.finish()
//            }
//
//            self?.timer = Timer(timeInterval: 0.0, repeats: true) { [unowned self] timer in
//                print(self!.player.currentTime())
//                let snapshot = try! self!.imageGenerator?.copyCGImage(at: self!.player.currentTime(), actualTime: nil)
//                continuation.yield(snapshot)
//            }
//            RunLoop.main.add(self!.timer!, forMode: .default)
//            self?.player.play()
//
//        }
        player.play()
    }

    func stop() {
        player.pause()
    }
}
