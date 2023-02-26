//
//  HistoryCellTableViewCell.swift
//  Upark
//
//  Created by IT on 11/8/19.
//  Copyright © 2019 IT. All rights reserved.
//

import UIKit

class HistoryCellTableViewCell: UITableViewCell {

    @IBOutlet weak var codeUILB: UILabel!
    @IBOutlet weak var redDateUILB: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initWithItem(item : HistoryInfo) {
        codeUILB.text = item.code
        redDateUILB.text = item.regdate
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
