import Foundation

enum OnBoardingPageIndex: Int {
    case first = 0
    case second

    var imageName: String {
        switch self {
        case .first:
            return R.image.on_boarding_picture_1.name
        case .second:
            return R.image.on_boarding_picture_2.name
        }
    }

    var title: String {
        switch self {
        case .first:
            return R.string.onBoardingStrings.first_page_title()
        case .second:
            return R.string.onBoardingStrings.second_page_title()
        }
    }

    var subTitle: String {
        switch self {
        case .first:
            return R.string.onBoardingStrings.first_page_subtitle()
        case .second:
            return R.string.onBoardingStrings.second_page_subtitle()
        }
    }

    var nextPage: OnBoardingPageIndex? {
        switch self {
        case .first:
            return .second
        case .second:
            return nil
        }
    }
}
