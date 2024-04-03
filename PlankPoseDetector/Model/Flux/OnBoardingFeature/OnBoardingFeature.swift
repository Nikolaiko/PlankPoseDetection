import Foundation
import ComposableArchitecture

@Reducer
struct OnBoardingFeature {

    @ObservableState
    struct State {
        var currentPageIndex: OnBoardingPageIndex = .first
    }

    enum Action {
        case nextPage
        case complete
    }

    @Dependency(\.userDataService) var userDataService

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .nextPage:
            if let nextPage = state.currentPageIndex.nextPage {
                state.currentPageIndex = nextPage
                return .none
            } else {
                userDataService.setOnBoardingStatus(completed: true)
                return .send(.complete)
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
