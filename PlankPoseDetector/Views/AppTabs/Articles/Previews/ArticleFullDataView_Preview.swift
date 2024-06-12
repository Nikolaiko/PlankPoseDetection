import Foundation
import SwiftUI
import ComposableArchitecture
import ArticlesTab

#Preview("ArticleFullDataView_Preview") {
    GeometryReader { _ in
        ArticleFullDataView(
            stateStore: Store(
                initialState: ArticleDetail.State(
                    id: "1",
                    title: "Preview"
                ),
                reducer: { ArticleDetail() }
            )
        )
    }
}
