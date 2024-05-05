import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let stateStore: StoreOf<HomeFeature>

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
