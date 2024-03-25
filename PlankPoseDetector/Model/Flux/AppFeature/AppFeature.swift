import Foundation
import ComposableArchitecture

@Reducer
struct AppFeature {

    @ObservableState
    struct State {
        @Presents var destination: AppFeatureDestination.State?
    }

    enum Action {
        case destination(PresentationAction<AppFeatureDestination.Action>)
        case goToOnboarding
        case goToMainView
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .goToOnboarding:
                state.destination = .onBoarding(StatisticsFeature.State())
                return .none
            case .goToMainView:
                state.destination = .mainView(HomeFeature.State())
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) 
    }

}
