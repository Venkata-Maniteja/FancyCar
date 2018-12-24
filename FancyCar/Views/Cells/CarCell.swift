//
//  CarCell.swift
//  FancyCar
//
//  Created by Keystroke on 2018-12-20.
//  Copyright © 2018 Keystroke. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {
    
    @IBOutlet weak var iconV: UIImageView!
    @IBOutlet weak var availableIconV: UIImageView!
    @IBOutlet weak var buyIcon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var make: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var contentHolder: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        customiseBackground()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customiseBackground(){
        backgroundColor = UIColor.clear
        contentHolder.layer.cornerRadius = 5
        contentHolder.layer.masksToBounds = false
        contentHolder.layer.shadowOffset = CGSize(width: 1, height: 1)
        contentHolder.layer.shadowRadius = 3
        contentHolder.layer.shadowOpacity = 0.5
    }
    
}
