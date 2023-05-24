//
//  HUDViewModel.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 20.05.2023.
//

import Foundation
import SwiftUI

class HUDViewModel: ObservableObject, HUDMessengerDelegate {
    @Published var currentErrorMessage: HUDMessage?

    private let messageQueue = DispatchQueue(label: "messages")
    private var messages: [HUDMessage] = []
    private var messenger: HUDMessenger = StaticHUDMessenger.shared

    init() {
        messenger.callback = receiveMessage
    }

    func receiveMessage(message: HUDMessage) {
        messageQueue.async { [weak self] in
            self?.messages.append(message)
            if self?.messages.count == 1 {
                DispatchQueue.main.async {
                    self?.showMessage(message: message)
                }
            }
        }
    }

    private func showMessage(message: HUDMessage) {
        currentErrorMessage = message
        messageQueue.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.nextMessage()
        }
    }

    private func nextMessage() {
        messages.remove(at: 0)
        !messages.isEmpty ? showMessage(message: messages.first!) : hideMessage()
    }

    private func hideMessage() {
        DispatchQueue.main.async { [weak self] in
            self?.currentErrorMessage = nil
        }
    }
}
