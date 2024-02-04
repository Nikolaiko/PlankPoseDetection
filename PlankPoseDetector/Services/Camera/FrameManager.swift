//
//  FrameManager.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 11.02.2023.
//

import Foundation
import AVFoundation
import UIKit
import ComposableArchitecture

class FrameManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    static let shared = FrameManager()

    private var viewStore: ViewStore<CameraFeature.State, CameraFeature.Action>?

    private override init() {}

    func setStore(store: StoreOf<CameraFeature>) {
        viewStore = ViewStoreOf<CameraFeature>(store, observe: { $0 })
    }

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {        
        if let buffer = sampleBuffer.imageBuffer {
            let ciContext = CIContext()
            let ciImage = CIImage(cvImageBuffer: buffer)

            DispatchQueue.main.async { [weak self] in
                self?.viewStore?.send(.processFrame(ciContext.createCGImage(ciImage, from: ciImage.extent)))
            }
        }
    }
}
