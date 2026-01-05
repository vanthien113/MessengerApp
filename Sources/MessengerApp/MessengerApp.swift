import SwiftUI

@main
struct MessengerApp: App {
    var body: some Scene {
        WindowGroup {
            WebView(url: URL(string: "https://www.messenger.com")!)
                .frame(minWidth: 800, minHeight: 600)
        }
    }
}
