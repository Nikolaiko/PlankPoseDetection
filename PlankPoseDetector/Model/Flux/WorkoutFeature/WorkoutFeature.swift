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
        var sourceImage: UIImage?

        init(sourceImage: UIImage? = nil) {
            let url = Bundle.main.url(forResource: "example", withExtension: "jpg")
            self.sourceImage = UIImage(contentsOfFile: url!.path)!
        }
    }

    enum Action {
        case processImage
        case processImageResult(UIImage?)
    }

    private let detector = VisionPoseDetection()

    func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
        switch action {
        case .processImage:
            let image = state.sourceImage!
            return .task {
                .processImageResult(await detector.detectPoseOnImage(image: image))
            }
        case .processImageResult(let imageResult):
            if let res = imageResult {
                print("Success")
            } else {
                print("Failt")
            }
            return .none
        }
    }

    private func testProcess()  {



    }
}
