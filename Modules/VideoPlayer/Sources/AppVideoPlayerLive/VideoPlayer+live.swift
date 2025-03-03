import Foundation
import Dependencies
import AVFoundation
import AppVideoPlayer

extension AppVideoPlayer: DependencyKey {
    public static var liveValue: Self {
        let player: AVPlayer = AVPlayer()
        var framesStream: AsyncStream<CGImage?>?

        var imageGenerator: AVAssetImageGenerator?
        let timer = RepeatingTimer(timeInterval: 0.01)
        let streamBuilder: () -> AsyncStream<CGImage?> = {
            return AsyncStream<CGImage?> { continuation in
                continuation.onTermination = { _ in
                    continuation.finish()
                }

                timer.eventHandler = {
                    let snapshot = try? imageGenerator?.copyCGImage(
                        at: player.currentTime(),
                        actualTime: nil
                    )
                    print("Video player live player generator: \(imageGenerator)")
                    //print("Video player live player.currentTime: \(CMTimeGetSeconds(player.currentTime()))")
                    print("Video player live snapshot: \(snapshot)")
                    continuation.yield(snapshot)
                }
            }
        }

        return Self {
            player
        } streamInstance: {
            framesStream
        } isPlaying: {
            player.isPlaying()
        } loadItemFromUrl: { fileUrl in
            let item = AVPlayerItem(url: fileUrl)
            player.replaceCurrentItem(with: item)

            imageGenerator = AVAssetImageGenerator(asset: player.currentItem!.asset)
            imageGenerator?.appliesPreferredTrackTransform = true
        } play: {
            if framesStream == nil {
                framesStream = streamBuilder()
            }
            timer.resume()
            player.play()
        } stop: {
            timer.suspend()
            player.pause()
        }
    }
}
