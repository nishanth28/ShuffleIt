//
//  customCell.swift
//  ShuffleIt
//
//  Created by Nishanth P on 12/3/16.
//  Copyright © 2016 Nishapp. All rights reserved.
//

import UIKit
import Foundation

class customCell : UITableViewCell {
    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    
    @IBOutlet weak var songImage2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func setSelected(_ selected:Bool,animated : Bool) {
        super.setSelected(selected,animated:animated)
        // Dispose of any resources that can be recreated.
    }
    
    
}
