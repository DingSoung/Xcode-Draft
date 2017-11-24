//
//  ViewController.swift
//  WKWebJS
//
//  Created by Songwen Ding on 2017/11/24.
//  Copyright © 2017年 Songwen Ding. All rights reserved.
//

import UIKit
import WebKit

class ViewController: BaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem?.title = "返回"
        
        self.webView.configuration.userContentController = WKUserContentController()
        self.webView.uiDelegate = self
        
         self.webView.configuration.userContentController.add(self, name: "Pay")
         guard let  urlStr = Bundle.main.path(forResource: "index", ofType: "html") else { return }
         let url = URL(fileURLWithPath: urlStr)
         self.webView.loadFileURL(url, allowingReadAccessTo: url)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


public extension URL {
    public func setCookie(value: String, forName name: String) {
        var cookies = HTTPCookieStorage.shared.cookies(for: self) ?? []
        for index in 0..<cookies.count {
            if cookies[index].name == name {
                cookies.remove(at: index)
                break;
            }
        }
        guard let cookie = HTTPCookie(properties: [
            .name: name,
            .value: value,
            .originURL: self,
            .version: 0,
            .domain: self.host ?? "",
            .path: "/",
            .secure: self.scheme == "https://",
            .expires: Date.init(timeIntervalSinceNow: 3 * 365 * 24 * 60 * 60),
            .comment: "custom cookie",
            //.commentURL:
            //.discard
            //.maximumAge
            //.port
            ]) else { return }
        cookies.append(cookie)
        HTTPCookieStorage.shared.setCookies(cookies, for: self, mainDocumentURL: nil)
    }
}

fileprivate class DocsBarButtonItem: UIBarButtonItem {
    var id = ""
    var callback = ""
}

extension ViewController: WKScriptMessageHandler, WKUIDelegate  {
    // js call swift
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name, message.body)
    }
    
    @objc private func rightItensAction(sender: DocsBarButtonItem) {
        self.webView.evaluateJavaScript(sender.callback, completionHandler: nil)
    }
}

