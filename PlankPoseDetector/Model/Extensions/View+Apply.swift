//
//  View+Apply.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 10.09.2023.
//

import Foundation
import SwiftUI

extension View {

    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
}
