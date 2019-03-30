//
//  WebViewPay.swift
//  TZONE
//
//  Created by youssef on 3/28/19.
//  Copyright © 2019 AmrSobhy. All rights reserved.
//

import UIKit
import WebKit

class WebViewPay: UIViewController,WKNavigationDelegate {
    var webView : WKWebView!
    var orderId = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        print("orderId")
        let url = URL(string: "http://prosolutions-it.com/tajjer/live_payment/index.php?order_id=\(orderId)")!
        webView.load(URLRequest(url: url))
        print("done \(orderId)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("orderId")
        let url = URL(string: "http://prosolutions-it.com/tajjer/live_payment/index.php?order_id=\(orderId)")!
        webView.load(URLRequest(url: url))
        print("done")
    }
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
