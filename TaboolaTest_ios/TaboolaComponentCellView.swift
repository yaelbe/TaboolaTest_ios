//
//  Component.swift
//  TaboolaTest_ios
//
//  Created by Yael Bilu Eran on 12/12/2018.
//  Copyright © 2018 yit. All rights reserved.
//

import UIKit
import TaboolaSDK

class TaboolaComponentCellView: UITableViewCell {

    @IBOutlet weak var taboolaView: TaboolaView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

