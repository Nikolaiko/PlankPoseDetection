import Foundation
import SwiftUI
import ComposableArchitecture

#Preview("AppTabs_HomeTab_Preview") {
    GeometryReader { geometry in
        VStack {
            Spacer()
            AppBottomBar(
                geometry: geometry,
                store: Store(
                    initialState: AuthorizedFeature.State.homeTab(HomeFeature.State()), reducer: {
                        AuthorizedFeature()
                    })
            )
        }
    }
}
