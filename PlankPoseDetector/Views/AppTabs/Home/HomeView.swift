import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let stateStore: StoreOf<HomeFeature>

    var body: some View {
        GeometryReader { geom in
            VStack {
                List {
                    ForEach(stateStore.loadedArticles) { currentArticle in
                        HStack {
                            Text(currentArticle.title)
                            AsyncImage(url: currentArticle.imageUrl) { loaded in
                                loaded.image?
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                }
            }
        }
        .background(Color.red)
        .onAppear {
            stateStore.send(.loadArticles)
        }
    }
}
