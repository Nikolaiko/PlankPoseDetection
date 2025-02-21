import Foundation
import Dependencies
import PoseDetection

enum UserDataDependency: DependencyKey {
    static var liveValue: any UserDataService = UserDefaultsService()
}

extension DependencyValues {
  var userDataService: any UserDataService {
    get { self[UserDataDependency.self] }
    set { self[UserDataDependency.self] = newValue }
  }
}
