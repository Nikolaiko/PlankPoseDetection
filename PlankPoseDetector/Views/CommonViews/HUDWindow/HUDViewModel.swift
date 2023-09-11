//
//  HUDViewModel.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 20.05.2023.
//

import Foundation
import SwiftUI

class HUDViewModel: ObservableObject, HUDMessengerDelegate {
    private static let animationDuration: TimeInterval = 2

    @Published var isPresented = false
    var messages: [HUDMessage] = []

    private let messageQueue = DispatchQueue(label: "messages")
    private var messenger: HUDMessenger = StaticHUDMessenger.shared

    init() {
        messenger.callback = receiveMessage
    }

    func receiveMessage(message: HUDMessage) {
        messageQueue.async { [weak self] in
            self?.messages.append(message)
            if self?.isPresented == false {
                self?.showMessage(message: message)
            }
        }
    }

    private func showMessage(message: HUDMessage) {
        DispatchQueue.main.async { [weak self] in
            self?.isPresented = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + HUDViewModel.animationDuration) { [weak self] in
            self?.isPresented = false
        }
        messageQueue.asyncAfter(deadline: .now() + HUDViewModel.animationDuration * 2) { [weak self] in
            self?.nextMessage()
        }
    }

    private func nextMessage() {
        messages.remove(at: 0)
        if !messages.isEmpty {
            showMessage(message: messages.first!)
        }
    }
}
