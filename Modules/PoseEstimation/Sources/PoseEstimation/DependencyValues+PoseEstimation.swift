import Dependencies

public extension DependencyValues {
    var poseEstimation: PoseEstimationService {
      get { self[PoseEstimationService.self] }
      set { self[PoseEstimationService.self] = newValue }
    }
}
