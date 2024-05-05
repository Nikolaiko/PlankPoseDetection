import Foundation
import SwiftUI

#Preview("Empty_ArticleShortDataRow_Preview") {
    ArticleShortDataRow(
        imageUrl: nil,
        title: "Test 1",
        subtitle: "Test 1"
    )
}

#Preview("ArticleShortDataRow_Preview") {
    ArticleShortDataRow(
        imageUrl: Bundle.main.url(forResource: "Preview_Article_Icon", withExtension: "png"),
        title: "Test 1",
        subtitle: "Test 1"
    )
}
