import SwiftUI
import ComposableArchitecture

struct MainView: View {
    @Bindable var stateStore: StoreOf<AppFeature>
    var body: some View {
        Group {
            ProgressView()
                .fullScreenCover(item: $stateStore.scope(
                    state: \.destination?.mainView,
                    action: \.destination.mainView
                )) { store in
                    AppTabsView(store: store)
                }
                .fullScreenCover(item: $stateStore.scope(
                    state: \.destination?.onBoarding,
                    action: \.destination.onBoarding
                )) { store in
                    OnBoardingView(store: store)
                }
        }
        .onAppear {
            stateStore.send(.checkOnboardingState)
        }

    }
}
