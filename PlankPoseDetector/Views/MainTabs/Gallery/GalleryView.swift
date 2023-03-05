//
//  GalleryView.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 21.02.2023.
//

import SwiftUI
import PhotosUI
import AVKit
import ComposableArchitecture

struct GalleryView: View {
    let stateStore: StoreOf<GalleryFeature>

    @State private var selectedItem: PhotosPickerItem? = nil

    var body: some View {
        WithViewStore(stateStore) { viewStore in
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        VideoPlayer(player: viewStore.activePlayer)
                        FrameView(image: viewStore.bodyFrame)
                        if viewStore.loadingVideo {
                            ProgressView()
                        }
                    }
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .videos,
                        photoLibrary: .shared()) {
                            Text("Выберите видео")
                        }
                        .onChange(of: selectedItem) { newItem in
                            viewStore.send(.startLoadingVideoFromGallery)
                            Task {                                
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    viewStore.send(.loadedVideoDataFromGallery(data))                                    
                                }
                            }
                        }
                }
            }            
        }
    }
}
