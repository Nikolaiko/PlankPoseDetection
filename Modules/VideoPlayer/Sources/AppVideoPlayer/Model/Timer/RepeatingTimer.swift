import Foundation

public class RepeatingTimer {

    public var eventHandler: VoidCallback?

    private var state: SourceTimerState = .suspended
    private let timeInterval: TimeInterval
    private lazy var timer: DispatchSourceTimer = {
        let sourceTimer = DispatchSource.makeTimerSource()
        sourceTimer.schedule(
            deadline: .now() + self.timeInterval,
            repeating: self.timeInterval
        )
        sourceTimer.setEventHandler(handler: { [weak self] in
            self?.eventHandler?()
        })
        return sourceTimer
    }()

    public init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }

    public func resume() {
        if state == .resumed {
            return
        }
        state = .resumed
        timer.resume()
    }

    public func suspend() {
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
