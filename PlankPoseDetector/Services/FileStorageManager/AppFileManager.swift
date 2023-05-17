//
//  FileManager.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 18.03.2023.
//

import Foundation

protocol AppFileManager {
    func loadDataFromUrl(videoData: Data) -> URL?
    func getSavedFiles() -> [SavedVideoFile]
}
