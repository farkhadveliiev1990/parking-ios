//
//  CaptureViewController.swift
//  Upark
//
//  Created by IT on 11/6/19.
//  Copyright © 2019 IT. All rights reserved.
//

import UIKit
import WebKit

class CaptureViewController: UIViewController {

    @IBOutlet weak var backUIIMG: UIImageView!
    @IBOutlet weak var captureWV: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIView()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initUIView() {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.captureWV.frame.size.width, height: self.captureWV.frame.size.height))
        self.captureWV.addSubview(webView)
        let url = URL(string: "http://softeck.dyndns.info/fmi/webd/Parking%20Web?script=TicketEscaneado&param=")
        webView.load(URLRequest(url: url!))

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
            backUIIMG.isUserInteractionEnabled = true
            backUIIMG.addGestureRecognizer(singleTap)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func tapDetected() {
        self.navigationController?.popViewController(animated: true)
    }

    
}
