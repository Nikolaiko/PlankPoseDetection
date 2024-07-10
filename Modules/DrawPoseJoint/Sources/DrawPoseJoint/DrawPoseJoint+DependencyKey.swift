import Dependencies

public extension DependencyValues {
  var paintService: DrawPoseJoint {
    get { self[DrawPoseJoint.self] }
    set { self[DrawPoseJoint.self] = newValue }
  }
}
