import XCTest
@testable import ArticlesProvider

final class ArticlesJsonProviderTests: XCTestCase {
    private let provider = ArticlesJsonProvider()

    func testGetAllArticlesNotFailing() {
        XCTAssertNoThrow(provider.getAllArticlesInfo(), "Загрузка не должна приводить к исключению")
    }

    func testGetAllArticlesNotNull() {
        let loadedArticles = provider.getAllArticlesInfo()
        XCTAssertFalse(loadedArticles.isEmpty, "Загруженный список не должен быть пустым")
    }

    func testGetAllArticlesHaveImages() {
        let loadedArticles = provider.getAllArticlesInfo()
        XCTAssertFalse(loadedArticles.isEmpty, "Загруженный список не должен быть пустым")

        for article in loadedArticles {
            XCTAssertNotNil(article.imageUrl, "Картинка у статьи \(article.title), не должна быть пустой")
        }
    }
}
