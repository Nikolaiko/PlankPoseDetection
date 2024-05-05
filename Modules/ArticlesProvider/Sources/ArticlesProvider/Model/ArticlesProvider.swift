import Foundation

public protocol ArticlesProvider {
    func getAllArticlesInfo() -> [ShortArticleInfo]
}
