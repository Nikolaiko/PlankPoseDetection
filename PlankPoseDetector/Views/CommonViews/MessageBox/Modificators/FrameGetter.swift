//
//  FrameGetter.swift
//  MessageViewExample
//
//  Created by Nikolai Baklanov on 02.09.2023.
//

import Foundation
import SwiftUI

struct FrameGetter: ViewModifier {

    @Binding var frame: CGRect
    @Binding var safeArea: EdgeInsets

    public func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geom -> AnyView in
                    let rect = geom.frame(in: .global)
                    if rect.integral != frame.integral {
                        DispatchQueue.main.async {
                            self.frame = rect
                            self.safeArea = geom.safeAreaInsets
                        }
                    }
                    return AnyView(EmptyView())
                }
            )
    }
}
