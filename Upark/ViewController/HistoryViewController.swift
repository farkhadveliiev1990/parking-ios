//
//  HistoryViewController.swift
//  Upark
//
//  Created by IT on 11/8/19.
//  Copyright © 2019 IT. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var backUIIMG: UIImageView!
    @IBOutlet weak var historyUITV: UITableView!
    
    var historyArr = [HistoryInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUIView()
        initDatas()
        
        historyUITV.register(UINib(nibName: "HistoryCellTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryCellTableViewCell")
        historyUITV.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initUIView() {
        let singleTap = UITapGestureRecognizer(target: self , action: #selector(tapDedteced))
        backUIIMG.isUserInteractionEnabled = true
        backUIIMG.addGestureRecognizer(singleTap)
        
        self.historyUITV.dataSource = self
    }
    
    func initDatas() {
        self.historyArr.removeAll()
        for _ in 0...4{
            let histroy = HistoryInfo();
            self.historyArr.append(histroy)
        }
        self.historyUITV.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func tapDedteced() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HistoryViewController : UITableViewDataSource{
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCellTableViewCell", for: indexPath) as! HistoryCellTableViewCell
        let item = historyArr[indexPath.row]
        cell.initWithItem(item: item)
        return cell
    }
    
}


