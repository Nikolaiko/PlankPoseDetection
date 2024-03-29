import Foundation
import SwiftUI
import ComposableArchitecture

#Preview("OnBaording_Page_1") {
    OnBoardingView(store: Store(initialState: OnBoardingFeature.State(currentPageIndex: 0),
                                reducer: {
        OnBoardingFeature()
    }))
}

#Preview("OnBaording_Page_2") {
    OnBoardingView(store: Store(initialState: OnBoardingFeature.State(currentPageIndex: 1),
                                reducer: {
        OnBoardingFeature()
    }))
}
