import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    let url: URL

    func makeNSView(context: Context) -> WKWebView {
        let webView = RestorableWebView()
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        nsView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        // Handle navigation actions (clicking links)
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }

            // Only intercept explicit user clicks
            if navigationAction.navigationType == .linkActivated {
                 if let host = url.host, host.contains("messenger.com") {
                     decisionHandler(.allow)
                 } else {
                     NSWorkspace.shared.open(url)
                     decisionHandler(.cancel)
                 }
                 return
            }

            // Allow all other navigations (redirects, initial loads, etc.)
            decisionHandler(.allow)
        }

        // Handle new window requests (target="_blank")
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if let url = navigationAction.request.url {
                NSWorkspace.shared.open(url)
            }
            return nil
        }
    }
}

class RestorableWebView: WKWebView {
    private var windowObservation: NSKeyValueObservation?

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        guard let window = window else { return }
        
        // Restore frame from UserDefaults
        if let savedFrameString = UserDefaults.standard.string(forKey: "ManualWindowFrame") {
            let savedFrame = NSRectFromString(savedFrameString)
            if savedFrame != .zero {
                // Apply asynchronously to allow SwiftUI to finish its initial layout pass
                DispatchQueue.main.async {
                    window.setFrame(savedFrame, display: true)
                }
            }
        }
        
        // Observe frame changes to save immediately
        // We use NotificationCenter for window move/resize events
        NotificationCenter.default.addObserver(self, selector: #selector(windowDidResizeOrMove), name: NSWindow.didResizeNotification, object: window)
        NotificationCenter.default.addObserver(self, selector: #selector(windowDidResizeOrMove), name: NSWindow.didMoveNotification, object: window)
    }
    
    @objc private func windowDidResizeOrMove() {
        guard let window = window else { return }
        let frameString = NSStringFromRect(window.frame)
        UserDefaults.standard.set(frameString, forKey: "ManualWindowFrame")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
