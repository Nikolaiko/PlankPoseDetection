import Foundation
import SwiftUI

public struct ArticlesJsonProvider: ArticlesProvider {

    public init() { }

    public func getArticleContent(id: String) -> String? {
        guard let settingsURL = Bundle.module.url(forResource: id, withExtension: "html"),
              let fileData = try? Data(contentsOf: settingsURL),
              let fileContent = String(data: fileData, encoding: .utf8)
        else { return nil }
        return fileContent
    }

    public func getAllArticlesInfo() -> [ShortArticleInfo] {
        guard let settingsURL = Bundle.module.url(forResource: "articles", withExtension: "json"),
              let fileData = try? Data(contentsOf: settingsURL),
              let parsedData = try? JSONDecoder().decode([ShortArticlesStorageData].self, from: fileData)
        else { return [] }
        
        return parsedData.map { storageData in
            ShortArticleInfo(
                id: storageData.id,
                title: storageData.title,
                subtitle: storageData.subtitle,
                imageUrl: Bundle.module.url(forResource: storageData.imageName, withExtension: "png")
            )
        }
    }
}
