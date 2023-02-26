//
//  ContactViewController.swift
//  Upark
//
//  Created by IT on 11/6/19.
//  Copyright © 2019 IT. All rights reserved.
//

import UIKit
import SendGrid_Swift

class ContactViewController: UIViewController {

    var SENDGRID_APIKEY : String = "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"
    
    @IBOutlet weak var backUIIMG: UIImageView!
    @IBOutlet weak var emailUITF: UITextField!
    @IBOutlet weak var contentUITV: UITextView!
    @IBOutlet weak var sendUIB: UIButton!
    
    @IBOutlet var mainUIV: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIView()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initUIView(){
        emailUITF.layer.masksToBounds = true
        emailUITF.layer.cornerRadius = emailUITF.frame.height/2
        emailUITF.layer.borderWidth = 1
        emailUITF.layer.borderColor = UIColor(named: "color_border")?.cgColor
        emailUITF.delegate = self
        
        contentUITV.layer.masksToBounds = true
        contentUITV.layer.cornerRadius = 10
        contentUITV.layer.borderWidth = 1
        contentUITV.layer.borderColor = UIColor(named: "color_border")?.cgColor
        contentUITV.text = "Contenido del correo electrónico que se enviará a soporte."
        contentUITV.textColor = UIColor.lightGray
        contentUITV.delegate = self
        
        sendUIB.layer.cornerRadius = 10
        sendUIB.layer.borderWidth = 3
        sendUIB.layer.borderColor = UIColor(named: "color_border")?.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleMainTap))
        mainUIV.addGestureRecognizer(tapGesture)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        backUIIMG.isUserInteractionEnabled = true
        backUIIMG.addGestureRecognizer(singleTap)
    }
    
    @objc func handleMainTap(){
        emailUITF.resignFirstResponder()
        contentUITV.resignFirstResponder()
    }
    
    @objc func tapDetected() {
        self.navigationController?.popViewController(animated: true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func clickSendUIB(_ sender: Any) {
        let sendGrid = SendGrid(withAPIKey: SENDGRID_APIKEY)
    
        let content = SGContent(type: .plain, value: contentUITV.text)
        let from = SGAddress(email: emailUITF.text!)
        let personalization = SGPersonalization(to: [ SGAddress(email: "lromo@publicity.com") ])
        
        
        let email = SendGridEmail(personalizations: [personalization], from: from, subject: "Equipo de soporte de Upark", content: [content])
        
        sendGrid.send(email: email) { (response, error) in
            if error != nil {
                self.showToast(message: "Failed")
            }
        }
    }
   
}

extension ContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ContactViewController: UITextViewDelegate{    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Contenido del correo electrónico que se enviará a soporte."
            textView.textColor = UIColor.lightGray
        }
    }
}
