import Foundation
import UIKit

public struct SavedVideoFile: Equatable, Identifiable {
    public var id: URL { url }

    public let name: String
    public let url: URL
    public let thumbnail: UIImage

    public init(name: String, url: URL, thumbnail: UIImage) {
        self.name = name
        self.url = url
        self.thumbnail = thumbnail
    }
}
