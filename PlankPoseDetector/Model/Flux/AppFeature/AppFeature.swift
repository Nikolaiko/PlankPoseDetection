import Foundation
import ComposableArchitecture
import Dependencies

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
        case checkOnboardingState
    }

    @Dependency(\.userDataService) var userDataService: any UserDataService

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .goToOnboarding:
                state.destination = .onBoarding(OnBoardingFeature.State())
                return .none
            case .goToMainView:
                state.destination = .mainView(AuthorizedFeature.State.homeTab(HomeFeature.State()))
                return .none
            case .checkOnboardingState:
                let onBoardingCompleted = userDataService.isOnBoardingCompleted()
                return .send(onBoardingCompleted ? .goToMainView : .goToOnboarding)
            case .destination(.presented(.onBoarding(.complete))):
                return .send(.checkOnboardingState)
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) 
    }

}
