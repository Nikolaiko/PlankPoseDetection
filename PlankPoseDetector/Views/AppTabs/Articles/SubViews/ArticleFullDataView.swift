import SwiftUI
import ComposableArchitecture
import ArticlesTab

struct ArticleFullDataView: View {
    let stateStore: StoreOf<ArticleDetail>

    var body: some View {
        VStack {
            Text(stateStore.title)
            HTMLView(htmlContent: stateStore.content)
        }
        .onAppear {
            stateStore.send(.loadArticle(stateStore.id))
        }
    }
}
