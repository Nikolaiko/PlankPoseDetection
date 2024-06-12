import Foundation
import SwiftUI
import Dependencies

extension ArticlesProvider: DependencyKey {
    public static let liveValue = Self(
        allProvidersInfo: {
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
        },
        articleContent: { id in
            guard let settingsURL = Bundle.module.url(forResource: id, withExtension: "html"),
                  let fileData = try? Data(contentsOf: settingsURL),
                  let fileContent = String(data: fileData, encoding: .utf8)
            else { return nil }
            return fileContent
        }
    )
}

public extension DependencyValues {
    var articlesProvider: ArticlesProvider {
        get { self[ArticlesProvider.self] }
        set { self[ArticlesProvider.self] = newValue }
    }
}
