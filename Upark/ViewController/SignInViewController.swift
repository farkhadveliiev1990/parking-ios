//
//  SignInViewController.swift
//  Upark
//
//  Created by IT on 11/5/19.
//  Copyright © 2019 IT. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleUtilities

class SignInViewController: UIViewController{

    @IBOutlet weak var emailUITF: UITextField!
    @IBOutlet weak var passwordUITF: UITextField!
    @IBOutlet weak var checkPrivacyUIB: UIButton!
    @IBOutlet weak var loginUIB: UIButton!
    @IBOutlet weak var googleUIB: UIButton!
    @IBOutlet var mainUIV: UIView!
    @IBOutlet weak var backUIIMG: UIImageView!
    @IBOutlet weak var privacyUILB: UILabel!
    
    @IBOutlet weak var checkUIB: UIButton!
    var isChecked = false
    var isCheckedPrivacy = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        initUIView()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initUIView() {
        emailUITF.layer.masksToBounds = true
        emailUITF.layer.cornerRadius = emailUITF.frame.height/2
        emailUITF.layer.borderWidth = 2
        emailUITF.layer.borderColor = UIColor(named: "color_border")?.cgColor
        emailUITF.delegate = self
        
        passwordUITF.layer.masksToBounds = true
        passwordUITF.layer.cornerRadius = passwordUITF.frame.height/2
        passwordUITF.layer.borderWidth = 2
        passwordUITF.layer.borderColor = UIColor(named: "color_border")?.cgColor
        passwordUITF.delegate = self
        
        loginUIB.layer.cornerRadius = 20
        loginUIB.layer.borderWidth = 2
        loginUIB.layer.borderColor = UIColor(named: "color_border")?.cgColor
        
        googleUIB.layer.cornerRadius = 20
        googleUIB.layer.borderWidth = 2
        googleUIB.layer.borderColor = UIColor(named: "color_border")?.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleMainTap))
        mainUIV.addGestureRecognizer(tapGesture)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        backUIIMG.isUserInteractionEnabled = true
        backUIIMG.addGestureRecognizer(singleTap)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        privacyUILB.isUserInteractionEnabled = true
        privacyUILB.addGestureRecognizer(tap)
    }
    
    @objc func handleMainTap(){
        emailUITF.resignFirstResponder()
        passwordUITF.resignFirstResponder()
    }
    
    func CheckAccountFireBase(email: String, pass: String) {
        Auth.auth().signIn(withEmail: email, password: pass) {  (user, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            if (user?.user.isEmailVerified)! {
                gUser = UserModel()
                gUser.id = (user?.user.uid)!
                var ref: DatabaseReference!
                ref = Database.database().reference()
                ref.child("Users").child(gUser.id).observe(.value, with: {
                    (snapshot) in
                    let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                    gUser.fromFirebase(data: postDict)
                    self.onShowNextController()
                })
            }
        }
    }
    
    func onShowNextController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        navigationController?.pushViewController(vc, animated: true)
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
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ModalPrivacyViewController") as! ModalPrivacyViewController
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func clickCheckUIB(_ sender: UIButton) {
        checkUIB.setBackgroundImage(UIImage(named: "img_check"), for: .selected)
        checkUIB.setBackgroundImage(UIImage(named: "img_uncheck"), for: .normal)
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func clickCheckPrivacyUIB(_ sender: UIButton) {
        checkPrivacyUIB.setBackgroundImage(UIImage(named: "img_check"), for: .selected)
        checkPrivacyUIB.setBackgroundImage(UIImage(named: "img_uncheck"), for: .normal)
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func clickLoginUIB(_ sender: Any) {
        let email: String = emailUITF.text!
        let password: String = passwordUITF.text!
        
        if email == "" {
            showToast(message: "El correo esta vacio.")
            return
        }
        if (!email.contains("@")) || (!email.contains(".com")) {
            showToast(message: "El formato del correo electrónico es incorrecto.")
            return
        }
        if password == "" {
            showToast(message: "La contraseña esta vacía")
            return
        }
                
        let passwordSha1: String = Global.sha1(password: password)
        
        CheckAccountFireBase(email: email, pass: passwordSha1)
    }

    @IBAction func clickGoogleUIB(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
}

extension SignInViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        //
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
