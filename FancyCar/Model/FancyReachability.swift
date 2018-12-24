//
//  FancyReachability.swift
//  FancyCar
//
//  Created by Venkata on 2018-12-21.
//  Copyright © 2018 Keystroke. All rights reserved.
//

import UIKit
import Reachability

class FancyReachability: NSObject {

}

extension UIViewController{
    
    // MARK: Reachabaility methods - begin
    func startObservingNetworkChanges(){
        let reachability = Reachability()!
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
            showFancyAlert(title: "Network Lost", msg: "Please connect to a network to recieve updates", icon: "icon_no_wifi")
        }
    }
    
    func isNetworkAvailable() -> Bool{
        let reachability = Reachability()!
        if reachability.connection == .none{
           return false
        }
        return true
    }
}
