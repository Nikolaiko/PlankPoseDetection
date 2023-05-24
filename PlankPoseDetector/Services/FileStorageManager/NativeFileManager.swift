//
//  NativeFileManager.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 18.03.2023.
//

import Foundation
import AVFoundation
import UIKit

struct NativeFileManager: AppFileManager {
    private let fileManager = FileManager.default

    func removeSavedFiles() throws {
        let documentsDirPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let content = try fileManager.contentsOfDirectory(atPath: documentsDirPath.path())
        for currentFile in content {
            let fileUrl = documentsDirPath.appending(path: currentFile)
            try fileManager.removeItem(at: fileUrl)
        }
    }

    func getSavedFiles() -> [SavedVideoFile] {
        let documentsDirPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        var filesList: [SavedVideoFile] = []

        do {
            let content = try fileManager.contentsOfDirectory(atPath: documentsDirPath.path())
            for currentFile in content {
                let fileUrl = documentsDirPath.appending(path: currentFile)
                let asset = AVURLAsset(url: fileUrl, options: nil)

                var imageGenerator = AVAssetImageGenerator(asset: asset)
                imageGenerator.appliesPreferredTrackTransform = true
                let cgImage = try imageGenerator.copyCGImage(
                    at: CMTimeMake(value: 0, timescale: 1),
                    actualTime: nil
                )
                let thumbnail = UIImage(cgImage: cgImage)

                filesList.append(
                    SavedVideoFile(
                        name: currentFile,
                        url: fileUrl,
                        thumbnail: thumbnail
                    )
                )
            }
        } catch {
            print("Error during explorer")
            filesList = []
        }
        return filesList
    }

    func loadDataFromUrl(videoData: Data) -> URL? {
        let documentsDirPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "\(Date.now).mp4"
        let url = documentsDirPath.appending(path: fileName)

        do {
            try videoData.write(to: url)
            return url
        } catch {
            print("Error during save temp file: \(error)")
            return nil
        }        
    }
}
