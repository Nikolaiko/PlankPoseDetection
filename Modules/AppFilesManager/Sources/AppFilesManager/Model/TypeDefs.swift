import Foundation

public typealias DataLoader = (Data) -> URL?
public typealias VoidCallback = () throws -> Void
public typealias SavedFilesLoader = () -> [SavedVideoFile]
