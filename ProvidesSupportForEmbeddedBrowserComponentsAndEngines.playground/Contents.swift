import UIKit
import WebKit
import PlaygroundSupport

// Create a view controller
class WebViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Configure the web view with a user content controller
        let contentController = WKUserContentController()
        contentController.add(self, name: "callbackHandler")

        // Setup the web configuration
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        config.processPool = WKProcessPool() // For isolating session

        // Initialize WKWebView
        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.navigationDelegate = self
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)

        // Load HTML content
        let html = """
        <html>
        <body>
        <h2>Hello from WKWebView!</h2>
        <button onclick="window.webkit.messageHandlers.callbackHandler.postMessage('Hello from JS!')">Tap Me</button>
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }

    // Handle JavaScript messages
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "callbackHandler", let body = message.body as? String {
            print("JavaScript says: \(body)")
        }
    }

    // Optional: handle page loading events
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Page loaded!")
    }
}

// Setup playground live view
PlaygroundPage.current.liveView = WebViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
