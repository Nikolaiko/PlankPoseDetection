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
    private let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "com.nikolai.SessionQ")
    private let videoOutput = AVCaptureVideoDataOutput()

    struct State: Equatable {
        var cameraConfig: CameraConfigurationState = .unconfigured
    }

    enum Action {
        case prepare
        case configure(CameraConfigurationState)
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .prepare:
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

            ConfigureSession(state: &state)
            session.startRunning()
            return .none
        }
    }

    private func ConfigureSession(state: inout State) {
        guard state.cameraConfig == .unconfigured else { return }

        session.beginConfiguration()
        defer { session.commitConfiguration() }

        let device = AVCaptureDevice.default(
            .builtInWideAngleCamera,
            for: .video,
            position: .front
        )
        guard let camera = device else {
            state.cameraConfig = .failed
            return
        }

        do {
            let cameraInput = try AVCaptureDeviceInput(device: camera)
            if session.canAddInput(cameraInput) {
                session.addInput(cameraInput)
            } else {
                state.cameraConfig = .failed
                return
            }
        } catch {
            state.cameraConfig = .failed
            return
        }

        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
            videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]

            let videoConnection = videoOutput.connection(with: .video)
            videoConnection?.videoOrientation = .portrait
        } else {
            state.cameraConfig = .failed
            return
        }
        state.cameraConfig = .configured
    }

    //    private func checkPermissions() {
    //      switch AVCaptureDevice.authorizationStatus(for: .video) {
    //      case .notDetermined:
    //        sessionQueue.suspend()
    //        AVCaptureDevice.requestAccess(for: .video) { authorized in
    //          if !authorized {
    //            self.status = .unauthorized
    //            self.set(error: .deniedAuthorization)
    //          }
    //          self.sessionQueue.resume()
    //        }
    //      // 4
    //      case .restricted:
    //        status = .unauthorized
    //        set(error: .restrictedAuthorization)
    //      case .denied:
    //        status = .unauthorized
    //        set(error: .deniedAuthorization)
    //      // 5
    //      case .authorized:
    //        break
    //      // 6
    //      @unknown default:
    //        status = .unauthorized
    //        set(error: .unknownAuthorization)
    //      }
    //    }
}
