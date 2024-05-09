import Foundation

public protocol ArticlesProvider {
    func getAllArticlesInfo() -> [ShortArticleInfo]
    func getArticleContent(id: String) -> String?
}
