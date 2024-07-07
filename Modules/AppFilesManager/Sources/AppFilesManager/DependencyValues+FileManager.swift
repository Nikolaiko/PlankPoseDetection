import Dependencies

public extension DependencyValues {
    var fileManager: AppFilesManager {
      get { self[AppFilesManager.self] }
      set { self[AppFilesManager.self] = newValue }
    }
}
