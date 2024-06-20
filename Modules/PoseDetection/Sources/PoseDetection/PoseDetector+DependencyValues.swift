import Foundation
import Dependencies

extension DependencyValues {
  public var poseDetector: PoseDetector {
    get { self[PoseDetector.self] }
    set { self[PoseDetector.self] = newValue }
  }
}
