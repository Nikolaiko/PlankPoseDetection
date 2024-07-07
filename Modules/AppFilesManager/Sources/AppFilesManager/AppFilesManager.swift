import Foundation

public struct AppFilesManager {
    public var loadDataFromUrl: DataLoader
    public var removeSavedFiles: VoidCallback
    public var getSavedFiles: SavedFilesLoader

    public init(
        loadDataFromUrl: @escaping DataLoader,
        removeSavedFiles: @escaping VoidCallback,
        getSavedFiles: @escaping SavedFilesLoader
    ) {
        self.loadDataFromUrl = loadDataFromUrl
        self.removeSavedFiles = removeSavedFiles
        self.getSavedFiles = getSavedFiles
    }
}
