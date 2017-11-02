//
//  WebViewController.swift
//  ToyFriendsApplication
//
//  Created by sgcs on 2017. 11. 3..
//  Copyright © 2017년 Kwanghee Choi. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var query: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.webView.load(URLRequest(url: URL(string: "https://www.google.com/search?q=" + self.query!)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rewind(_ sender: Any) {
        self.webView.goBack()
    }
    
    @IBAction func stop(_ sender: Any) {
        self.webView.stopLoading()
    }
    
    @IBAction func reload(_ sender: Any) {
        self.webView.reload()
    }
    
    @IBAction func fastforward(_ sender: Any) {
        self.webView.goForward()
    }
    
    @IBAction func close(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
