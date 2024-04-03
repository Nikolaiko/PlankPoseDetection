import SwiftUI
import ComposableArchitecture

struct OnBoardingView: View {
    let store: StoreOf<OnBoardingFeature>

    var body: some View {
        VStack {
            Image(store.currentPageIndex.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 36.0)

            Text(store.currentPageIndex.title)
                .font(Font.custom("Poppins-Bold", size: 26.0))
                .foregroundColor(Color(uiColor: R.color.blackColor()!))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16.0)
                .padding(.bottom, 16)

            Text(store.currentPageIndex.subTitle)
                .font(Font.custom("Poppins-Regular", size: 14.0))
                .foregroundColor(Color(uiColor: R.color.gray1()!))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16.0)

            Spacer()
            HStack {
                Spacer()
                Image(R.image.on_boarding_button)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60.0, height: 60.0)
                    .padding(.trailing, 36.0)
                    .onTapGesture {
                        store.send(.nextPage)
                    }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}
