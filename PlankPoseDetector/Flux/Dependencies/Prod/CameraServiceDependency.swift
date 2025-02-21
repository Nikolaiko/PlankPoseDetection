//
//  CameraServiceDependency.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 18.02.2023.
//

import Foundation
import Dependencies

enum CameraServiceDependency: DependencyKey {
    static var liveValue = AsyncCameraService()
}

extension DependencyValues {
  var cameraService: AsyncCameraService {
    get { self[CameraServiceDependency.self] }
    set { self[CameraServiceDependency.self] = newValue }
  }
}
