//
//  DetectViewModel.swift
//  PoseDetectionTestToll
//
//  Created by Nikolai Baklanov on 22.10.2023.
//

import Foundation
import PoseDetection
import SwiftUI
import Vision

class DetectViewModel: ObservableObject {
    private let detection = PoseDetector.liveValue
    private let drawing = CGImagePainter()
    private let bundle = Bundle.main

    @Published var result: NSImage? = nil

    func detect() {
        let imageUrl = bundle.url(forResource: "image1", withExtension: "png")
        let image = NSImage(contentsOf: imageUrl!)!
        var imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        let imageRef = image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)!
        let poses = detection.detectPoses(imageRef)

        result = drawing.drawPointsOnImage(sourceImage: imageRef, points: poses)

        print("Joints count: \(poses.count)")
        for pose in poses {
            print("Key: \(pose.key.rawValue) : Value: \(pose.value)")
        }
    }
}

