//
//  FirstViewController.swift
//  Upark
//
//  Created by IT on 11/4/19.
//  Copyright © 2019 IT. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var loginUVB: UIButton!
    @IBOutlet weak var signupUVb: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        initUIView()
        // Do any additional setup after loading the view.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initUIView(){
        loginUVB.layer.cornerRadius = 20
        loginUVB.layer.borderWidth = 3
        loginUVB.layer.borderColor = UIColor(named: "color_border")?.cgColor
        
        signupUVb.layer.cornerRadius = 20
        signupUVb.layer.borderWidth = 3
        signupUVb.layer.borderColor = UIColor(named: "color_border")?.cgColor
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


