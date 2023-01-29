//
//  WorkoutFeature.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 23.01.2023.
//

import Foundation
import ComposableArchitecture
import UIKit

struct WorkoutFeature: ReducerProtocol {
    struct State: Equatable {
        var sourceImage: UIImage
        var resultImage: UIImage?
        var isProcessing: Bool = false

        init() {
            let url = Bundle.main.url(forResource: "example", withExtension: "jpg")
            self.sourceImage = UIImage(contentsOfFile: url!.path)!
        }
    }

    enum Action {
        case processImage
        case processImageResult(UIImage?)
    }

    private let detector = VisionPoseDetection()
    private let painter = CGImagePainter()

    func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
        switch action {
        case .processImage:
            state.isProcessing = true
            let image = state.sourceImage
            return .task {
                let points = detector.detectPoseOnImage(image: image)
                let resultImage = painter.drawPointsOnImage(sourceImage: image, points: points)

                return .processImageResult(resultImage)
            }
        case .processImageResult(let imageResult):
            if let res = imageResult {
                state.resultImage = res
            } else {
                print("Failt")
            }
            state.isProcessing = false
            return .none
        }
    }

    private func testProcess()  {



    }
}
