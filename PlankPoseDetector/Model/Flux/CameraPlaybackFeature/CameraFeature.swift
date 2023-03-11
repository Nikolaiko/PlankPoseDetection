//
//  CameraFeature.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 08.02.2023.
//

import Foundation
import AVFoundation
import ComposableArchitecture

struct CameraFeature: ReducerProtocol {

    struct State: Equatable {
        var cameraConfig: CameraConfigurationState = .unconfigured
        let sessionQueue = DispatchQueue(label: "com.nikolai.SessionQ")
        let session = AVCaptureSession()
        let videoOutput = AVCaptureVideoDataOutput()

        var currentFrame: CGImage?
    }

    enum Action: Equatable {
        case checkPermissions
        case configure(CameraConfigurationState)
        case processFrame(CGImage?)
        case sendFrameToParent(CGImage?)
    }

    @Dependency(\.cameraService) var cameraService: AsyncCameraService

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .checkPermissions:
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                return .task {
                    let authorized = await AVCaptureDevice.requestAccess(for: .video)
                    return .configure(authorized ? .unconfigured : .unauthorized)
                }
            case .restricted:
                return EffectTask(value: .configure(.unauthorized))
            case .denied:
                return EffectTask(value: .configure(.unauthorized))
            case .authorized:
                return EffectTask(value: .configure(.unconfigured))
            @unknown default:
                return EffectTask(value: .configure(.unauthorized))
            }
        case .configure(let newConfigState):
            state.cameraConfig = newConfigState
            configureSession(state: &state)

            let queueState = state
            if state.cameraConfig != .failed {
                DispatchQueue(label: "sessionStart", qos: .userInitiated).async {
                    queueState.session.startRunning()
                }
            }
            return Effect.run { send in
                cameraService.startListening()
                for await currentFrame in cameraService.framesStream! {
                    await send(.processFrame(currentFrame))
                }
            }
        case .processFrame(let frameImage):
            state.currentFrame = frameImage
            return Effect(value: .sendFrameToParent(frameImage))
        default:
            return .none
        }
    }

    private func configureSession(state: inout State) {
        guard state.cameraConfig == .unconfigured else { return }

        state.session.beginConfiguration()
        defer { state.session.commitConfiguration() }

        let device = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .back
        )
        guard let camera = device else {
            state.cameraConfig = .failed
            return
        }

        do {
            let cameraInput = try AVCaptureDeviceInput(device: camera)
            if state.session.canAddInput(cameraInput) {
                state.session.addInput(cameraInput)
            } else {
                state.cameraConfig = .failed
                return
            }
        } catch {
            state.cameraConfig = .failed
            return
        }

        if state.session.canAddOutput(state.videoOutput) {
            state.session.addOutput(state.videoOutput)

            state.videoOutput.setSampleBufferDelegate(cameraService.frameDelegate, queue: state.sessionQueue)
            state.videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]

            let videoConnection = state.videoOutput.connection(with: .video)
            videoConnection?.videoOrientation = .portrait
        } else {
            state.cameraConfig = .failed
            return
        }
        state.cameraConfig = .configured
    }
}
