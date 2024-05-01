import Foundation
import ArticlesJsonProvider

extension ShortArticleInfo: Identifiable {
    public var id: String { title }
}
