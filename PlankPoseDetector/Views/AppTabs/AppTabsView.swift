import SwiftUI
import ComposableArchitecture

struct AppTabsView: View {
    @Bindable var store: StoreOf<AuthorizedFeature>

    var body: some View {
        GeometryReader { geom in
            VStack {
                switch store.state {
                case .homeTab:
                    if let store = store.scope(state: \.homeTab, action: \.homeTab) {
                        HomeView(stateStore: store)
                    }
                case .statsTab:
                    if let store = store.scope(state: \.statsTab, action: \.statsTab) {
                        StatisticsView(stateStore: store)
                    }
                case .galleryTab:
                    if let store = store.scope(state: \.galleryTab, action: \.galleryTab) {
                        GalleryView(stateStore: store)
                    }
                case .settingsTab:
                    if let store = store.scope(state: \.settingsTab, action: \.settingsTab) {
                        SettingsView(stateStore: store)
                    }
                }
                Spacer()
                AppBottomBar(geometry: geom, store: store)
            }
        }
    }
}
