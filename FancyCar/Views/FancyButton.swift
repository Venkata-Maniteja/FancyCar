//
//  FancyButton.swift
//  FancyCar
//
//  Created by Keystroke on 2018-12-20.
//  Copyright © 2018 Keystroke. All rights reserved.
//

import UIKit

class FancyButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        
          applyCustomisation()
        
    }
    
    private func applyCustomisation(){
        
        if let titleColor = titleColor(for: .normal){
            layer.borderColor = titleColor.cgColor
            backgroundColor = titleColor.withAlphaComponent(0.2)
        }
        
        layer.borderWidth = 2.0
        layer.cornerRadius = frame.size.height/2
    }

}

extension UIButton {
    
    func animateClick() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.1
        pulse.fromValue = 0.96
        pulse.toValue = 1.0
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.8
        
        layer.add(pulse, forKey: "pulse")
    }
    
   
}
