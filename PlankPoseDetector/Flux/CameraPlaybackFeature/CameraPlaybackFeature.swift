import Foundation
import ComposableArchitecture

struct CameraPlaybackFeature: Reducer {

    struct State: Equatable {
        var cameraState: CameraFeature.State? = CameraFeature.State()
        var drawingState: PoseDrawingFeature.State? = PoseDrawingFeature.State()        
    }

    enum Action {
        case cameraAction(CameraFeature.Action)
        case poseDrawingAction(PoseDrawingFeature.Action)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .cameraAction(let childAction):
                return processCameraAction(state: &state, action: childAction)
            default:
                return .none
            }
        }
        .ifLet(\.cameraState, action: /Action.cameraAction) {
            CameraFeature()
        }
        .ifLet(\.drawingState, action: /Action.poseDrawingAction) {
            PoseDrawingFeature()
        }
    }

    private func processCameraAction(
        state: inout CameraPlaybackFeature.State,
        action: CameraFeature.Action
    ) -> Effect<CameraPlaybackFeature.Action> {
        switch action {
        case .sendFrameToParent(let image):
            return Effect.send(CameraPlaybackFeature.Action.poseDrawingAction(.frameFromParent(image)))
        default:
            return .none
        }
    }

}
