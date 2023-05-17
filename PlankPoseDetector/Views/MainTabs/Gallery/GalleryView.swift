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

    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        WithViewStore(stateStore) { viewStore in            
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        if viewStore.bodyFrame == nil {
                            SavedFilesExplorer(
                                filesList: viewStore.savedFilesList) { selectedFile in
                                    viewStore.send(.saveDataToTempFolderResult(selectedFile.url))
                                }
                        } else {
                            VideoPlayer(player: viewStore.activePlayer)
                            FrameView(image: viewStore.bodyFrame)
                            VideoPlayerOverlay(
                                isPlaying: viewStore.activePlayer?.isPlaying() ?? false,
                                geometry: geometry,
                                onBackButton: {
                                    viewStore.send(.backToGallery)
                                },
                                onPlayPause: { viewStore.send(.togglePlayerState) }
                            )
                        }
                        if viewStore.loadingVideo || viewStore.loadingFilesList {
                            ProgressView()
                        }
                    }
                    if viewStore.bodyFrame == nil {
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .videos,
                            photoLibrary: .shared()) {
                                Text("Загрузить видео из галлереи")
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
                .onAppear {
                    viewStore.send(.startLoadingFilesList)
                }
            }            
        }
    }
}
