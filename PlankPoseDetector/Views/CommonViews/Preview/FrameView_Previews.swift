//
//  FrameView_Previews.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 11.03.2023.
//

import Foundation
import UIKit
import SwiftUI

struct FrameViewEmptyPreviews: PreviewProvider {
    static var previews: some View {
        FrameView(image: nil)
    }
}

struct FrameViewVideoFramePreviews: PreviewProvider {
    static var previews: some View {
        let url = Bundle.main.url(forResource: "VideoPreviewImage", withExtension: "jpg")
        let fileData: Data? = try? Data(contentsOf: url!)
        let image = fileData == nil ? nil : UIImage(data: fileData!)
        FrameView(image: image?.cgImage)
    }
}

struct FrameViewLandscapeFramePreviews: PreviewProvider {
    static var previews: some View {
        let url = Bundle.main.url(forResource: "LandscaprePose", withExtension: "png")
        let fileData: Data? = try? Data(contentsOf: url!)
        let image = fileData == nil ? nil : UIImage(data: fileData!)
        FrameView(image: image?.cgImage)
    }
}
