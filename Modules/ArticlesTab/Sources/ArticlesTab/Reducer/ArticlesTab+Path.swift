import Foundation
import ComposableArchitecture

extension ArticlesTab {
    @Reducer
    public enum Path {
        case detail(ArticleDetail)
    }
}
