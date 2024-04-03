//
//  SavedFilesExplorer.swift
//  PlankPoseDetector
//
//  Created by Nikolai Baklanov on 18.03.2023.
//

import SwiftUI

struct SavedFilesExplorer: View {
    let filesList: [SavedVideoFile]
    let onItemTap: SelectingFileCallback?

    var body: some View {
        List {
            ForEach(filesList) { file in
                Image(uiImage: file.thumbnail)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        onItemTap?(file)
                    }
            }
        }
    }
}

struct SavedFilesExplorer_Previews: PreviewProvider {
    static var previews: some View {
        SavedFilesExplorer(
            filesList: [], onItemTap: nil
        )
    }
}
