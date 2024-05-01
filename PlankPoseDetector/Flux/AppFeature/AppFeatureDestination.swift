import ComposableArchitecture
import Foundation

@Reducer
enum AppFeatureDestination {
    case mainView(AuthorizedFeature)
    case onBoarding(OnBoardingFeature)

    @ObservableState
    enum State: CaseReducerState {
        typealias StateReducer = AppFeatureDestination

        case mainView(AuthorizedFeature.State)
        case onBoarding(OnBoardingFeature.State)
    }
}
