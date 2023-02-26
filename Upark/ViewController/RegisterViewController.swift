//
//  RegisterViewController.swift
//  Upark
//
//  Created by IT on 11/5/19.
//  Copyright © 2019 IT. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameUITF: UITextField!
    @IBOutlet weak var emailUITF: UITextField!
    @IBOutlet weak var phoneUITF: UITextField!
    @IBOutlet weak var passwordUITF: UITextField!
    
    @IBOutlet weak var backUIIMG: UIImageView!
    @IBOutlet weak var registerUIB: UIButton!
    
    @IBOutlet var mainUIV: UIView!
    
    var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUIView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initUIView(){
        nameUITF.layer.masksToBounds = true
        nameUITF.layer.cornerRadius = emailUITF.frame.height/2
        nameUITF.layer.borderWidth = 2
        nameUITF.layer.borderColor = UIColor(named: "color_border")?.cgColor
        nameUITF.delegate = self
        
        emailUITF.layer.masksToBounds = true
        emailUITF.layer.cornerRadius = emailUITF.frame.height/2
        emailUITF.layer.borderWidth = 2
        emailUITF.layer.borderColor = UIColor(named: "color_border")?.cgColor
        emailUITF.delegate = self
        
        phoneUITF.layer.masksToBounds = true
        phoneUITF.layer.cornerRadius = emailUITF.frame.height/2
        phoneUITF.layer.borderWidth = 2
        phoneUITF.layer.borderColor = UIColor(named: "color_border")?.cgColor
        phoneUITF.delegate = self
        
        passwordUITF.layer.masksToBounds = true
        passwordUITF.layer.cornerRadius = passwordUITF.frame.height/2
        passwordUITF.layer.borderWidth = 2
        passwordUITF.layer.borderColor = UIColor(named: "color_border")?.cgColor
        passwordUITF.delegate = self
        
        registerUIB.layer.cornerRadius = 20
        registerUIB.layer.borderWidth = 2
        registerUIB.layer.borderColor = UIColor(named: "color_border")?.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleMainTap))
        mainUIV.addGestureRecognizer(tapGesture)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        backUIIMG.isUserInteractionEnabled = true
        backUIIMG.addGestureRecognizer(singleTap)
    }
    
    @objc func handleMainTap(){
        nameUITF.resignFirstResponder()
        emailUITF.resignFirstResponder()
        phoneUITF.resignFirstResponder()
        passwordUITF.resignFirstResponder()
    }
    
    @objc func tapDetected() {
        self.navigationController?.popViewController(animated: true)
    }
        
    @IBAction func clickRegisterUIB(_ sender: Any) {
        let name: String = nameUITF.text!
        let email: String = emailUITF.text!
        let phone: String = phoneUITF.text!
        let password: String = passwordUITF.text!
        
        if name == "" {
            showToast(message: "El nombre esta vacio.")
            return
        }
        if email == "" {
            showToast(message: "El correo esta vacio.")
            return
        }
        if (!email.contains("@")) || (!email.contains(".com")) {
            showToast(message: "El formato del correo electrónico es incorrecto.")
            return
        }
        if phone == "" {
            showToast(message: "El número de teléfono está vacío.")
            return
        }
        if password == "" {
            showToast(message: "La contraseña esta vacía")
            return
        }
        
        let passwordSha1: String = Global.sha1(password: password)
        
        gUser.name = name
        gUser.email = email
        gUser.phone = phone
        
        RegisterAccountFireBase(email: email, pass: passwordSha1)
    }

    func RegisterAccountFireBase(email : String, pass: String){
        Auth.auth().createUser(withEmail: email, password: pass){ (user, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            gUser.id = (user?.user.uid)!
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("Users").child(gUser.id).setValue(gUser.toFirebaseData())
            
            user?.user.sendEmailVerification(completion: ({
                (error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                
                try? Auth.auth().signOut()
                self.navigationController?.popViewController(animated: true)
            }))
        }
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

extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
