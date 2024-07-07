import Dependencies

public extension DependencyValues {
    var videoPlayer: AppVideoPlayer {
      get { self[AppVideoPlayer.self] }
      set { self[AppVideoPlayer.self] = newValue }
    }
}
