import Foundation

protocol UserDataService {
    func isOnBoardingCompleted() -> Bool
    func setOnBoardingStatus(completed: Bool)
}
