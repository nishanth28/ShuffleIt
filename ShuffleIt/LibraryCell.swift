//
//  LibraryCell.swift
//  ShuffleIt
//
//  Created by Nishanth P on 12/3/16.
//  Copyright © 2016 Nishapp. All rights reserved.
//

import UIKit
import Foundation

class LibraryCell : UITableViewCell {
    
    @IBOutlet weak var librarySongName: UILabel!
    @IBOutlet weak var libraryImage: UIImageView!
    @IBOutlet weak var libraryAlbumName: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func setSelected(_ selected:Bool,animated : Bool) {
        super.setSelected(selected,animated:animated)
        // Dispose of any resources that can be recreated.
    }
    
    
}

