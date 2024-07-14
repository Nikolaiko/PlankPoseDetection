import SwiftUI
import PhotosUI
import AVKit
import ComposableArchitecture
import GalleryTab

struct GalleryView: View {
    let stateStore: StoreOf<GalleryTab>

    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    if stateStore.bodyFrame == nil {
                        SavedFilesExplorer(
                            filesList: stateStore.savedFilesList) { selectedFile in
                                stateStore.send(.saveDataToTempFolderResult(selectedFile.url))
                            }
                    } else {
                        VideoPlayer(player: stateStore.activePlayer)
                        FrameView(image: stateStore.bodyFrame)
                        VideoPlayerOverlay(
                            isPlaying: stateStore.activePlayer?.isPlaying() ?? false,
                            geometry: geometry,
                            onBackButton: {
                                stateStore.send(.backToGallery)
                            },
                            onPlayPause: { stateStore.send(.togglePlayerState) }
                        )
                    }
                    if stateStore.loadingVideo || stateStore.loadingFilesList {
                        ProgressView()
                    }
                }
                if stateStore.bodyFrame == nil {
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .videos,
                        photoLibrary: .shared()) {
                            Text("Загрузить видео из галлереи")
                        }
                        .onChange(of: selectedItem) {
                            stateStore.send(.startLoadingVideoFromGallery)
                            Task {
                                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                                    stateStore.send(.loadedVideoDataFromGallery(data))
                                }
                            }
                        }
                }
            }
            .onAppear {
                stateStore.send(.startLoadingFilesList)
            }
        }
    }
}
