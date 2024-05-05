import Foundation
import SwiftUI
import ComposableArchitecture

#Preview("HomeView_Preview") {
    GeometryReader { _ in
        HomeView(stateStore: Store(
            initialState: HomeFeature.State(), reducer: { HomeFeature() }
        ))
    }
}
