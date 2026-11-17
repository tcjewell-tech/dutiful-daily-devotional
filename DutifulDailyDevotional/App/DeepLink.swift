import Foundation

enum DeepLink: Equatable {
    case today

    init?(url: URL) {
        guard url.scheme == AppConstants.urlScheme, url.host == "today" else { return nil }
        self = .today
    }
}
