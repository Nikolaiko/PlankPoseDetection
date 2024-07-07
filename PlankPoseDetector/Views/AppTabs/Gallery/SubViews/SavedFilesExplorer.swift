import SwiftUI
import AppFilesManager

struct SavedFilesExplorer: View {
    let filesList: [SavedVideoFile]
    let onItemTap: ((SavedVideoFile) -> Void)?

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
