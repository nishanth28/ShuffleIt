//
//  ProfilePic.swift
//  ShuffleIt
//
//  Created by Nishanth P on 1/12/17.
//  Copyright © 2017 Nishapp. All rights reserved.
//

import UIKit

class ProfilePic: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
       layer.shadowRadius = 5.0
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width/2
        
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
