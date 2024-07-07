import Foundation
import AVFoundation

public struct AppVideoPlayer {
    public var playerInstance: PlayerProvider
    public var streamInstance: StreamProvider

    public var isPlaying: PlaybackStatusProvider
    public var loadItemFromUrl: VideoLoader
    public var play: VoidCallback
    public var stop: VoidCallback

    public init(playerInstance: @escaping PlayerProvider,
                streamInstance: @escaping StreamProvider,
                isPlaying: @escaping PlaybackStatusProvider,
                loadItemFromUrl: @escaping VideoLoader,
                play: @escaping VoidCallback,
                stop: @escaping VoidCallback
    ) {
        self.playerInstance = playerInstance
        self.streamInstance = streamInstance
        self.isPlaying = isPlaying
        self.loadItemFromUrl = loadItemFromUrl
        self.play = play
        self.stop = stop
    }
}
