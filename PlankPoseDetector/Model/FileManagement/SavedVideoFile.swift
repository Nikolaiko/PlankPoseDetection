//
//  SavedVideoFile.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 18.03.2023.
//

import Foundation
import UIKit

struct SavedVideoFile: Equatable, Identifiable {
    var id: URL { url }

    let name: String
    let url: URL
    let thumbnail: UIImage
}
