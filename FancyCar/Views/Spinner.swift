//
//  Spinner.swift
//  FancyCar
//
//  Created by Keystroke on 2018-12-20.
//  Copyright © 2018 Keystroke. All rights reserved.
//

import UIKit

class Spinner: UIView {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
   public func showSpinner(){
    
       let imgV = UIImageView(image: UIImage(named: "icon_tire"))
       addSubview(imgV)
       imgV.center = CGPoint(x: self.frame.size.width  / 2,
                                 y: self.frame.size.height / 2)
       imgV.rotate()
    
       let msg = UILabel(frame: CGRect(x: 10, y: imgV.frame.size.height + 20, width: self.frame.size.width - 20, height: 30))
       msg.text = "Fetching cars..."
       msg.numberOfLines = 0
       msg.lineBreakMode = .byWordWrapping
       msg.textColor = UIColor.darkGray
       addSubview(msg)
    
    
    }
    
   public func hideSpinner(){
        removeFromSuperview()
    }

}

extension UIView{
    
    func rotate(){
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue =  2 * Double.pi
        rotation.duration = 0.5
        rotation.repeatCount = Float.infinity
        layer.removeAllAnimations()
        layer.add(rotation, forKey: "spin")
    }
    
}
