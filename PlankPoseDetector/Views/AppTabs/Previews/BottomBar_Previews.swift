import Foundation
import SwiftUI
import ComposableArchitecture
import ArticlesTab

let state = AuthorizedFeature.State.articlesTab(ArticlesTab.State())

#Preview("AppTabs_ArticlesTab_Preview") {
    GeometryReader { geometry in
        VStack {
            Spacer()
            AppBottomBar(
                geometry: geometry,
                store: Store(
                    initialState: state,
                    reducer: { AuthorizedFeature() }
                )
            )
        }
    }
}
