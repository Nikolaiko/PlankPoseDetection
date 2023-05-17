//
//  DispatchSourceTimer.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 05.03.2023.
//

import Foundation

class RepeatingTimer {

    var eventHandler: VoidCallback?

    private var state: SourceTimerState = .suspended
    private let timeInterval: TimeInterval
    private lazy var timer: DispatchSourceTimer = {
        let sourceTimer = DispatchSource.makeTimerSource()
        sourceTimer.schedule(
            deadline: .now() + self.timeInterval,
            repeating: self.timeInterval
        )
        sourceTimer.setEventHandler(handler: { [weak self] in
            print("Handling event!")
            self?.eventHandler?()
        })
        return sourceTimer
    }()

    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }

    func resume() {
        if state == .resumed {
            return
        }
        state = .resumed
        timer.resume()
    }

    func suspend() {
        if state == .suspended {
            return
        }
        state = .suspended
        timer.suspend()
    }

    deinit {
        timer.setEventHandler {}
        timer.cancel()
        resume()
        eventHandler = nil
    }
}
