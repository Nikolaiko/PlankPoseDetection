import Foundation
import AVFoundation

public typealias VoidCallback = () -> Void
public typealias VideoLoader = (URL) -> Void

public typealias PlaybackStatusProvider = () -> Bool
public typealias PlayerProvider = () -> AVPlayer
public typealias StreamProvider = () -> AsyncStream<CGImage?>?
