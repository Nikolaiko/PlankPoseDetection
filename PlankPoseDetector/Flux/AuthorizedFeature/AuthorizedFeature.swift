import ComposableArchitecture
import Foundation
import ArticlesTab
import GalleryTab

@Reducer
struct AuthorizedFeature {
    
    @ObservableState
    enum State {
        case articlesTab(ArticlesTab.State)
        case statsTab(StatisticsFeature.State)
        case galleryTab(GalleryTab.State)
        case settingsTab(SettingsFeature.State)

        var mainTabEnumValue: MainViewTabEnum {
            switch self {
            case .articlesTab:
                return .home
            case .statsTab:
                return .statistics
            case .galleryTab:
                return .gallery
            case .settingsTab:
                return .settings
            }
        }
    }

    enum Action {
        case articlesTab(ArticlesTab.Action)
        case statsTab(StatisticsFeature.Action)
        case galleryTab(GalleryTab.Action)
        case settingsTab(SettingsFeature.Action)
        case switchTab(MainViewTabEnum)
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.articlesTab, action: \.articlesTab) {
            ArticlesTab()
        }
        Scope(state: \.galleryTab, action: \.galleryTab) {
            GalleryTab()
        }
        Reduce { state, action in
            switch action {
            case .switchTab(let newTab):
                state = buildStateForTab(newTab: newTab)
                return .none
            default:
                return .none
            }
        }
    }

    private func buildStateForTab(newTab: MainViewTabEnum) -> AuthorizedFeature.State {
        switch newTab {
        case .home:
            return .articlesTab(ArticlesTab.State())
        case .gallery:
            return .galleryTab(GalleryTab.State())
        case .settings:
            return .settingsTab(SettingsFeature.State())
        case .statistics:
            return .statsTab(StatisticsFeature.State())
        }
    }
}
