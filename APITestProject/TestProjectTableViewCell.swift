//
//  TestProjectTableViewCell.swift
//  APITestProject
//
//  Created by Macbook Pro on 24/12/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class TestProjectTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTitleText: UILabel!
    @IBOutlet weak var lblDateText: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


