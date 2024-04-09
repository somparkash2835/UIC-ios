//
//  ViewController.swift
//  UIC
//
//  Created by Som on 08/04/24.
//

import UIKit
import WebKit
import OSLog

class WebViewViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loaderView: UIView!
    private let logger = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoader()
        self.loadWebView()
    }
    
    private func loadWebView(){
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        guard let url = URL(string: AppConstants.mainURL) else{
            logger.log("Web URL is not accurate.")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    private func showLoader(){
        self.loaderView.isHidden = false
        self.loaderView.alpha = 0.0
        UIView.animate(withDuration: 0.4) {
            self.loaderView.alpha = 1.0
        }
    }
    
    private func hideLoader(){
        UIView.animate(withDuration: 0.2) {
            self.loaderView.alpha = 0.0
        } completion: { complete in
            self.loaderView.isHidden = true
        }
        
    }
}

//MARK: - WebKit Delegates
extension WebViewViewController: WKUIDelegate, WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoader()
    }
}
