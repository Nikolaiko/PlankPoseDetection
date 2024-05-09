import SwiftUI

struct ArticleShortDataRow: View {
    let imageUrl: URL?
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40.0)
                } placeholder: {
                    Image("purple_gradient_circle")
                }
                .padding(.trailing, 10.0)

                VStack(alignment: .leading) {
                    Text(title)
                        .font(.smallTextMedium())
                        .foregroundStyle(Color.blackColor())

                    Spacer()

                    Text(subtitle)
                        .font(.captionRegular())
                        .foregroundStyle(Color.gray1())
                }
            }
            .frame(height: 40)
            .padding(.vertical, 16.0)

            Rectangle()
                .frame(height: 1.0)
                .foregroundStyle(Color.gray3())
        }
    }
}
