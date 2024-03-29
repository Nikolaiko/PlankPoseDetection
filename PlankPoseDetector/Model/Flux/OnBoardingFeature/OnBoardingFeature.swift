import Foundation
import ComposableArchitecture

@Reducer
struct OnBoardingFeature {

    @ObservableState
    struct State {
        var currentPageIndex = 0
    }

    enum Action {
        case nextPage
        case complete
    }

    @Dependency(\.userDataService) var userDataService

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .nextPage:
            if state.currentPageIndex + 1 > Config.maxPageCount {
                userDataService.setOnBoardingStatus(completed: true)
                return .send(.complete)
            } else {
                state.currentPageIndex += 1
                return .none
            }
        default:
            return .none
        }
    }
}

private extension OnBoardingFeature {
    enum Config {
        static let maxPageCount = 1
    }
}
