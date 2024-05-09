import SwiftUI
import ComposableArchitecture
import ArticlesTab

struct ArticlesView: View {
    let stateStore: StoreOf<ArticlesTab>

    var body: some View {
        ScrollView {
            ForEach(stateStore.loadedArticles) { currentArticle in
                ArticleShortDataRow(
                    imageUrl: currentArticle.imageUrl,
                    title: currentArticle.title,
                    subtitle: currentArticle.subtitle
                )
                .padding(.horizontal, 30.0)
            }
        }
        .onAppear {
            stateStore.send(.loadArticles)
        }
    }
}
