//
//  FrameStateManager.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 17.02.2023.
//

import Foundation
import AVFoundation
import UIKit
import ComposableArchitecture

class FrameStateManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    private var state: CameraFeature.State

    init(managerState: inout CameraFeature.State) {
        state = managerState
        super.init()
    }

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        if let buffer = sampleBuffer.imageBuffer {
            let ciContext = CIContext()
            let ciImage = CIImage(cvImageBuffer: buffer)

            state.currentFrame = ciContext.createCGImage(ciImage, from: ciImage.extent)
//            DispatchQueue.main.async { [weak self] in
//
//                //self?.viewStore?.send(.processFrame(ciContext.createCGImage(ciImage, from: ciImage.extent)))
//            }
        }
    }
}
