import Foundation
import ComposableArchitecture
import ArticlesProvider

@Reducer
public struct ArticlesTab {

    public init() { }

    @ObservableState
    public struct State {
        public var isLoading: Bool
        public var loadedArticles: [ShortArticleInfo]

        public init(isLoading: Bool = false, loadedArticles: [ShortArticleInfo] = []) {
            self.isLoading = isLoading
            self.loadedArticles = loadedArticles
        }
    }

    public enum Action {
        case loadArticles
    }

    @Dependency(\.articlesProvider) var aritclesProvider: any ArticlesProvider

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .loadArticles:
            state.loadedArticles = aritclesProvider.getAllArticlesInfo()
            print(aritclesProvider.getAllArticlesInfo())
            return .none
        }
    }
}
