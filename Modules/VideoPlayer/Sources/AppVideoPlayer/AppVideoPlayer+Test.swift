import Foundation
import Dependencies
import AVFoundation

extension AppVideoPlayer: TestDependencyKey {
    public static var testValue: Self {
        let player: AVPlayer = AVPlayer()
        var framesStream: AsyncStream<CGImage?>?

        var imageGenerator: AVAssetImageGenerator?
        var timer = RepeatingTimer(timeInterval: 0.01)
        var streamBuilder: () -> AsyncStream<CGImage?> = {
            return AsyncStream<CGImage?> { continuation in
                continuation.onTermination = { _ in
                    continuation.finish()
                }

                timer.eventHandler = {
                    let snapshot = try? imageGenerator?.copyCGImage(
                        at: player.currentTime(),
                        actualTime: nil
                    )
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
            guard let testFileUrl = Bundle.module.url(forResource: "Clip3",
                                                      withExtension: "mp4") else { return }
            let item = AVPlayerItem(url: testFileUrl)
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
