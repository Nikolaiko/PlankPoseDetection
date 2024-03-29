import Foundation

struct UserDefaultsService: UserDataService {

    func isOnBoardingCompleted() -> Bool {
        UserDefaults.standard.bool(forKey: FieldNames.onBoardingFlag.rawValue)
    }

    func setOnBoardingStatus(completed: Bool) {
        UserDefaults.standard.setValue(completed, forKey: FieldNames.onBoardingFlag.rawValue)
    }

    private enum FieldNames: String {
        case onBoardingFlag
    }
}
