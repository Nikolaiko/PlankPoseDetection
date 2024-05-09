import Foundation
import ArticlesProvider
import Dependencies

enum TabArticlesProvider: DependencyKey {
    static var liveValue: any ArticlesProvider = ArticlesJsonProvider()
}

extension DependencyValues {
  var articlesProvider: any ArticlesProvider {
    get { self[TabArticlesProvider.self] }
    set { self[TabArticlesProvider.self] = newValue }
  }
}

