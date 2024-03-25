import ComposableArchitecture
import Foundation

@Reducer
enum AppFeatureDestination {
    case mainView(HomeFeature)
    case onBoarding(StatisticsFeature)
    
    @ObservableState
    enum State: CaseReducerState {
        typealias StateReducer = AppFeatureDestination

        case mainView(HomeFeature.State)
        case onBoarding(StatisticsFeature.State)
    }
}
