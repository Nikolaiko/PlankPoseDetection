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

class CameraFrameDelegate: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    var frameCallback: FrameCallback?

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        if let buffer = sampleBuffer.imageBuffer {
            let ciContext = CIContext()
            let ciImage = CIImage(cvImageBuffer: buffer)

            frameCallback?(ciContext.createCGImage(ciImage, from: ciImage.extent))
        }
    }
}
