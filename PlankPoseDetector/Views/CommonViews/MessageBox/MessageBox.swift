//
//  MessageBox.swift
//  MessageViewExample
//
//  Created by Nikolai Baklanov on 02.09.2023.
//

import Foundation
import SwiftUI

struct MessageBox<MessageView: View>: ViewModifier {

    @Binding private var isPresented: Bool

    private let backGroundColor: Color
    private let view: () -> MessageView
    private let messageAnimation: Animation
    private let messageType: MessageType

    init(
        isPresented: Binding<Bool>,
        backGroundColor: Color,
        messageAnimation: Animation,
        messageType: MessageType,
        view: @escaping () -> MessageView
    ) {
        self._isPresented = isPresented
        self.backGroundColor = backGroundColor
        self.messageAnimation = messageAnimation
        self.messageType = messageType
        self.view = view
    }

    @State private var showContent: Bool = false
    @State private var showAnimatedContent: Bool = false

    @State private var parentRect: CGRect = CGRect.zero
    @State private var parentSafeArea: EdgeInsets = EdgeInsets()

    @State private var messageRect: CGRect = CGRect.zero
    @State private var messageSafeArea: EdgeInsets = EdgeInsets()

    private var backgroundOpacity: Double {
        showAnimatedContent ? 1.0 : 0.0
    }

    private var hiddentOffset: Double {
        if messageType == .banner {
            if parentRect.isEmpty {
                return -1000
            } else {
                return -parentRect.midY - messageRect.height
            }
        } else {
            if parentRect.isEmpty {
                return 1000
            } else {
                return UIScreen.main.bounds.height - parentRect.midY + messageRect.height
            }
        }
    }

    private var displayOffset: Double {
        switch messageType {
        case .banner:
            return parentRect.minY - parentSafeArea.top - parentRect.midY + messageRect.height / 2
        case .center:
            return -parentRect.midY + UIScreen.main.bounds.height / 2
        case .snackbar:
            return parentRect.minY + parentSafeArea.bottom + parentRect.height - parentRect.midY - messageRect.height / 2
        }
    }

    private var currentOffset: Double {
        showAnimatedContent ? displayOffset : hiddentOffset
    }

    func body(content: Content) -> some View {
        mainContent(content: content)
            .onAppear {
                appearAction(showMessage: isPresented)
            }
            .onChange(of: isPresented) { newValue in
                appearAction(showMessage: newValue)
            }
    }

    private func mainContent(content: Content) -> some View {
        ZStack {
            content
                .modifier(FrameGetter(frame: $parentRect, safeArea: $parentSafeArea))

            if showContent {
                messageBackground()
            }
        }
        .overlay {
            if showContent {
                messageContent()
            }
        }
    }

    private func messageContent() -> some View {
        return view()
            .applyIf(messageType != .center, apply: { targetView in
                targetView
                    .padding(
                        messageType == .banner ? .top : .bottom,
                        30
                    )
            })
            .modifier(FrameGetter(frame: $messageRect, safeArea: $messageSafeArea))
            .onTapGesture {
                isPresented = false
            }
            .offset(x: 0, y: currentOffset)
            .animation(messageAnimation, value: currentOffset)
    }

    private func messageBackground() -> some View {
        backGroundColor
            .ignoresSafeArea(.all)
            .opacity(backgroundOpacity)
            .animation(messageAnimation, value: isPresented)
    }

    private func appearAction(showMessage: Bool) {
        if showMessage {
            showContent = true
            DispatchQueue.main.async {
                self.showAnimatedContent = true
            }
        } else {
            showAnimatedContent = false
        }
    }
}
