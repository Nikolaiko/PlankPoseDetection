import Foundation
import AVFoundation

public extension AVPlayer {
    func isPlaying() -> Bool {
        return rate != 0 && error == nil
    }
}
