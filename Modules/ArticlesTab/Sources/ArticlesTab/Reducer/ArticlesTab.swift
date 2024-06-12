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
        public var stack = StackState<Path.State>()

        public init(isLoading: Bool = false, loadedArticles: [ShortArticleInfo] = []) {
            self.isLoading = isLoading
            self.loadedArticles = loadedArticles
        }
    }

    public enum Action {
        case loadArticles
        case stackAction(StackActionOf<Path>)
    }

    @Dependency(\.articlesProvider) var aritclesProvider: ArticlesProvider

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadArticles:
                state.loadedArticles = aritclesProvider.allProvidersInfo()
                return .none
            default:
                return .none
            }
        }
        .forEach(\.stack, action: \.stackAction)
    }
}
