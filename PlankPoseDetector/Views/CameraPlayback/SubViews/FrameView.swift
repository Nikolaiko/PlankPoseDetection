//
//  FrameView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 08.02.2023.
//

import SwiftUI

struct FrameView: View {
    let image: CGImage?

    var body: some View {        
        if let image = image {
          GeometryReader { geometry in
            Image(
                image,
                scale: 1.0,
                label: Text("Image Label")
            )
            .resizable()
            .scaledToFill()
            .frame(
                width: geometry.size.width,
                height: geometry.size.height,
                alignment: .center
            )
            .clipped()
          }
        } else {
            Color.black.opacity(0)
        }
    }
}

//struct FrameView_Previews: PreviewProvider {
//    static var previews: some View {
//        FrameView()
//    }
//}
