import Foundation
import SwiftUI

struct BottomBarIconSelected_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarIcon(
            imageSide: 24,
            iconType: MainViewTabEnum.statistics,
            selected: true
        )
    }
}

struct BottomBarIconUnSelected_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarIcon(
            imageSide: 24,
            iconType: MainViewTabEnum.statistics,
            selected: false
        )
    }
}
