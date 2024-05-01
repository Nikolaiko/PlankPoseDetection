import Foundation
import ComposableArchitecture
import ArticlesJsonProvider

@Reducer
struct HomeFeature {

    @ObservableState
    struct State {
        var isLoading = false
        var loadedArticles: [ShortArticleInfo] = []
    }

    enum Action {
        case loadArticles

        case prepareToClose(MainViewTabEnum)
        case readyToClose(MainViewTabEnum)
    }

    @Dependency(\.articlesProvider) var aritclesProvider: any ArticlesProvider

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .loadArticles:            
            state.loadedArticles = aritclesProvider.getAllArticlesInfo()
            return .none
        case .prepareToClose(let newTabId):
            return Effect.send(.readyToClose(newTabId))
        default:
            return .none
        }
    }
}
