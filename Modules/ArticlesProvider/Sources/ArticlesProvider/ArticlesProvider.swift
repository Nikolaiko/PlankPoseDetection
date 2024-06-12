import Foundation

public struct ArticlesProvider {
    public let allProvidersInfo: AllArticlesCallback
    public let articleContent: ArticleDataCallback

    public init(
        allProvidersInfo: @escaping AllArticlesCallback,
        articleContent: @escaping ArticleDataCallback
    ) {
        self.allProvidersInfo = allProvidersInfo
        self.articleContent = articleContent
    }
}
