//
//  CameraService.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 18.02.2023.
//

import Foundation
import UIKit

class AsyncCameraService {
    var framesStream: AsyncStream<CGImage?>?
    let frameDelegate = CameraFrameDelegate()

    func startListening() {
        framesStream = AsyncStream { [weak self] continuation in
            continuation.onTermination = { _ in                
                continuation.finish()
            }

            self?.frameDelegate.frameCallback = { image in
                continuation.yield(image)
            }
        }
    }

    func stopListening() {

    }
}
