import SwiftUI
import ComposableArchitecture
import ArticlesTab

struct ArticlesView: View {
    @Bindable var stateStore: StoreOf<ArticlesTab>

    public var body: some View {
        NavigationStack(
            path: $stateStore.scope(state: \.stack, action: \.stackAction)
        ) {
            ScrollView {
                ForEach(stateStore.loadedArticles) { currentArticle in
                    NavigationLink(
                        state: ArticlesTab.Path.State.detail(
                            ArticleDetail.State(id: currentArticle.id, title: currentArticle.title)
                        ),
                        label: {
                            ArticleShortDataRow(
                                imageUrl: currentArticle.imageUrl,
                                title: currentArticle.title,
                                subtitle: currentArticle.subtitle
                            )
                            .padding(.horizontal, 30.0)
                        }
                    )
                }
            }
        } destination: { destStore in
            switch destStore.case {
            case .detail(let detailStore):
                ArticleFullDataView(stateStore: detailStore)                    
            }
        }
        .onAppear {
            stateStore.send(.loadArticles)
        }
    }
}
