import UIKit
import WebKit

class BaseWebViewController: UIViewController {

    let webView = WKWebView()
    let progressView = UIProgressView()
    private var titleObserve: NSKeyValueObservation?
    private var progressObserve: NSKeyValueObservation?
    public var url: URL? {
        set {
            guard let u = newValue else { return }
            self.webView.load(URLRequest(url: u))
        }
        get { return self.webView.url }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)
        
        self.progressView.backgroundColor = UIColor.clear
        self.progressView.alpha = 0.0
        self.view.addSubview(self.progressView)
        
        self.progressObserve = self.webView.observe(\WKWebView.estimatedProgress, options: [.new]) { [weak self] (_, value) in
            guard let strongSelf = self, let progress = value.newValue else { return }
            if (progress <= 0 || progress >= 1) && strongSelf.progressView.alpha > 0 {
                UIView.animate(withDuration: 0.25, animations: { self?.progressView.alpha = 0 })
            } else if (progress > 0 || progress < 1) && strongSelf.progressView.alpha < 1  {
                UIView.animate(withDuration: 0.1, animations: { self?.progressView.alpha = 1 })
            }
            self?.progressView.progress = Float(strongSelf.webView.estimatedProgress)
        }
        self.titleObserve = self.webView.observe(\WKWebView.title, options: NSKeyValueObservingOptions.new) { [weak self] (_, value) in
            guard let title = value.newValue else { return }
            self?.title = title
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.progressView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.webView.frame = self.view.bounds
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BaseWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.progressView.progress = 0
    }
}

