//
//  WKWebViewController.swift
//  SwiftJSMessageHandler
//
//  Created by andyron on 2017/9/6.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import WebKit
import AVFoundation

class WKWebViewController: UIViewController, WKUIDelegate, WKScriptMessageHandler {
    
    lazy var webView: WKWebView = WKWebView(frame: self.view.frame)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initWKWebView()
    }
    
    func initWKWebView() {
        webView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webView.configuration.preferences.minimumFontSize = 40.0
        
        let urlStr = Bundle.main.path(forResource: "index.html", ofType: nil)
        let fileURL = URL(fileURLWithPath: urlStr!)
        webView.loadFileURL(fileURL, allowingReadAccessTo: fileURL)
        
        webView.uiDelegate = self
        view.addSubview(webView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        webView.configuration.userContentController.add(self, name: "Location")
        webView.configuration.userContentController.add(self, name: "Shake")
        webView.configuration.userContentController.add(self, name: "Pay")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "Location")
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "Shake")
        webView.configuration.userContentController.removeScriptMessageHandler(forName: "Pay")
    }

    // MARK: -
    func getLocation() {
        let jsStr = "setLocation('上海浦东新区')"
        webView.evaluateJavaScript(jsStr) { (result, error) in
            print("\(String(describing: result))----\(error)")
        }
    }
    
    func shakeAction() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    func payWithParams(tempDic: Any) {
       
        guard tempDic is NSDictionary else {
            return
        }
        
        let jsStr = "payResult('支付成功')"
        webView.evaluateJavaScript(jsStr) { (result, error) in
            print("\(result)----\(error)")
        }
    }
    
    // MARK: - WKUIDelegate
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: "提醒", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "知道了", style: .cancel, handler:{
            action in
            completionHandler()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == "Location" {
            getLocation()
        } else if message.name == "Shake" {
            shakeAction()
        } else if message.name == "Pay" {
            payWithParams(tempDic: message.body)
        }
    }
}
