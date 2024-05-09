import Foundation
import SwiftUI
import ComposableArchitecture
import ArticlesTab

#Preview("ArticlesView_Preview") {
    GeometryReader { _ in
        ArticlesView(stateStore: Store(
            initialState: ArticlesTab.State(),
            reducer: { ArticlesTab() }
        ))
    }
}
