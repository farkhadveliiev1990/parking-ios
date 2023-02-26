//
//  ModalPrivacyViewController.swift
//  Upark
//
//  Created by IT on 11/6/19.
//  Copyright © 2019 IT. All rights reserved.
//

import UIKit

class ModalPrivacyViewController: UIViewController {

    @IBOutlet weak var modalUIV: UIView!
    @IBOutlet weak var privacyUIB: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIView()
        // Do any additional setup after loading the view.
    }
    
    func initUIView(){
        privacyUIB.layer.cornerRadius = 20
        privacyUIB.layer.borderWidth = 2
        privacyUIB.layer.borderColor = UIColor(named: "color_border")?.cgColor
        
        modalUIV.layer.cornerRadius = 20
        modalUIV.layer.borderWidth = 2
        modalUIV.layer.borderColor = UIColor(named: "color_border")?.cgColor
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func clickPrivacyUIB(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}
