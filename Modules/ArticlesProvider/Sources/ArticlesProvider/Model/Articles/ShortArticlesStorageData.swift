import Foundation

public struct ShortArticlesStorageData: Decodable {
    public let id: String
    public let title: String
    public let subtitle: String
    public let imageName: String

    public init(id: String, title: String, subtitle: String, imageName: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
    }
}
