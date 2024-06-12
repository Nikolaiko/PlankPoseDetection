import Foundation

extension ArticlesProvider {
    public static let previewValue = Self(
        allProvidersInfo: {
            [
                ShortArticleInfo(
                    id: "1",
                    title: "PreviewTitle1",
                    subtitle: "PreviewSubTitle1",
                    imageUrl: Bundle.module.url(forResource: "image1", withExtension: "png")
                ),
                ShortArticleInfo(
                    id: "2",
                    title: "PreviewTitle2",
                    subtitle: "PreviewSubTitle2",
                    imageUrl: Bundle.module.url(forResource: "image2", withExtension: "png")
                )
            ]
        },
        articleContent: { _ in
            "<html><body><h1>Preview</h1></body></html>"
        }
    )
}
