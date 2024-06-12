import XCTest
import ArticlesProvider

@testable import ArticlesProviderLive

final class ArticlesJsonProviderTests: XCTestCase {
    private let provider = ArticlesProvider.liveValue

    func testGetAllArticlesNotFailing() {
        XCTAssertNoThrow(provider.allProvidersInfo(), "Загрузка не должна приводить к исключению")
    }

    func testGetAllArticlesNotNull() {
        let loadedArticles = provider.allProvidersInfo()
        XCTAssertFalse(loadedArticles.isEmpty, "Загруженный список не должен быть пустым")
    }

    func testGetAllArticlesHaveImages() {
        let loadedArticles = provider.allProvidersInfo()
        XCTAssertFalse(loadedArticles.isEmpty, "Загруженный список не должен быть пустым")

        for article in loadedArticles {
            XCTAssertNotNil(article.imageUrl, "Картинка у статьи \(article.title), не должна быть пустой")
        }
    }

    func testGetWrongIdContentFails() {
        let loadedString = provider.articleContent("wrongId")
        XCTAssertNil(loadedString, "Несуществующий id должен вернуть nil")
    }

    func testGetRealIdNotNil() {
        let loadedString = provider.articleContent("1")
        XCTAssertNotNil(loadedString, "Верный id должен вернуть какое-то значение")
    }
}
