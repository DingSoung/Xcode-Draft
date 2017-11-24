//
//  BaseWebViewController.swift
//
//  Created by Songwen Ding on 2017/11/23.
//

import UIKit
import WebKit

@objcMembers
public class BaseWebViewController: UIViewController {
    
    public let webView = { () -> WKWebView in
        let config = WKWebViewConfiguration()
        config.userContentController = WKUserContentController()
        return WKWebView(frame: .zero, configuration: config)
    }()
    
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
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image : nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseWebViewController.backBarButtonItemAction(sender:)))
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
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.progressView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.webView.frame = self.view.bounds
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backBarButtonItemAction(sender: UIBarButtonItemStyle) {
        if self.webView.isLoading {
            self.webView.stopLoading()
        } else if self.webView.canGoBack {
            self.webView.goBack()
        } else if let navi = self.navigationController, navi.viewControllers.count > 1 {
            navi.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension BaseWebViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.progressView.progress = 0
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
}

