import SwiftUI
import ComposableArchitecture

struct OnBoardingView: View {
    let store: StoreOf<OnBoardingFeature>

    var body: some View {
        VStack {
            Text("Page : \(store.currentPageIndex)")
            Button(action: {
                store.send(.nextPage)
            }, label: {
                Text("Button")
            })
        }

    }
}
