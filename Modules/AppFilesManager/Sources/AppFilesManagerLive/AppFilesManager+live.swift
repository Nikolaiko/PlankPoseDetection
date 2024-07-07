import Foundation
import Dependencies
import AVFoundation
import UIKit
import AppFilesManager

extension AppFilesManager: DependencyKey {
    public static var liveValue: Self {
        return Self { data in
            let fileManager = FileManager.default
            let documentsDirPath = fileManager.urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first!
            let fileName = "\(Date.now).mp4"
            let url = documentsDirPath.appending(path: fileName)

            do {
                try data.write(to: url)
                return url
            } catch {
                return nil
            }
        } removeSavedFiles: {
            let fileManager = FileManager.default
            let documentsDirPath = fileManager.urls(
                for: .documentDirectory, in: .userDomainMask).first!
            let content = try fileManager.contentsOfDirectory(
                atPath: documentsDirPath.path())
            for currentFile in content {
                let fileUrl = documentsDirPath.appending(path: currentFile)
                try fileManager.removeItem(at: fileUrl)
            }
        } getSavedFiles: {
            let fileManager = FileManager.default
            let documentsDirPath = fileManager.urls(
                for: .documentDirectory,
                in: .userDomainMask
            ).first!
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
                filesList = []
            }
            return filesList
        }

    }
}
