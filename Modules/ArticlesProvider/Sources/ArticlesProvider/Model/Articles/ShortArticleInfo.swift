import Foundation

public struct ShortArticleInfo: Identifiable {
    public let id: String
    public let title: String
    public let subtitle: String
    public let imageUrl: URL?

    public init(id: String, title: String, subtitle: String, imageUrl: URL?) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.imageUrl = imageUrl
    }
}
