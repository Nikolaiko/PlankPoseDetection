//
//  AppColors.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 29.01.2023.
//

import Foundation
import SwiftUI
import SwiftDevPackage

let purpleGradientFirst = Color(hex: 0xC58BF2)
let purpleGradientSecond = Color(hex: 0xEEA4CE)

let purpleLinearGradient = LinearGradient(
    colors: [purpleGradientFirst, purpleGradientSecond],
    startPoint: .leading,
    endPoint: .trailing
)
