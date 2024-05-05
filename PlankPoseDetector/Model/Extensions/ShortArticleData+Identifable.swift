import Foundation
import ArticlesProvider

extension ShortArticleInfo: Identifiable {
    public var id: String { title }
}
