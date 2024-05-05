import SwiftUI

extension Font {
    static func boldPoppins(size: CGFloat) -> Font {
        Font.custom("Poppins-Bold", size: size)
    }

    static func regularPoppins(size: CGFloat) -> Font {
        Font.custom("Poppins-Regular", size: size)
    }

    static func mediumPoppins(size: CGFloat) -> Font {
        Font.custom("Poppins-Medium", size: size)
    }

    static func smallTextMedium() -> Font {
        mediumPoppins(size: 14.0)
    }

    static func captionRegular() -> Font {
        regularPoppins(size: 10.0)
    }
}
