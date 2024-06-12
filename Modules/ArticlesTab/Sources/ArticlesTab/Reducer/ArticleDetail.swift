import Foundation
import ComposableArchitecture
import Dependencies
import ArticlesProvider

@Reducer
public struct ArticleDetail {
    public init() { }

    @ObservableState
    public struct State {
        public let id: String
        public let title: String
        public var content: String = ""

        public init(id: String, title: String) {
            self.title = title
            self.id = id
        }
    }

    public enum Action {
        case loadArticle(String)
        case close
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.articlesProvider) var aritclesProvider: ArticlesProvider

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .close:
                return .run { _ in
                    await self.dismiss()
                }
            case .loadArticle(let id):
                state.content = aritclesProvider.articleContent(id) ?? ""
                return .none
            }
        }
    }
}
