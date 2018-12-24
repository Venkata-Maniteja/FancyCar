//
//  FancyAlertController.swift
//  FancyCar
//
//  Created by Venkata on 2018-12-21.
//  Copyright © 2018 Keystroke. All rights reserved.
//

import UIKit

class FancyAlertController: UIAlertController {

    /// - Return: value that was set on `title`
    private(set) var originalTitle: String?
    private var spaceAdjustedTitle: String = ""
    private weak var imageView: UIImageView? = nil
    private var previousImgViewSize: CGSize = .zero
    
    override var title: String? {
        didSet {
            // Keep track of original title
            if title != spaceAdjustedTitle {
                originalTitle = title
            }
        }
    }
    
    /// - parameter image: `UIImage` to be displayed about title label
    func setTitleImage(_ image: UIImage?) {
        guard let imageView = self.imageView else {
            let imageView = UIImageView(image: image)
            self.view.addSubview(imageView)
            self.imageView = imageView
            return
        }
        imageView.image = image
    }
    
    // MARK: -  Layout code
    
    override func viewDidLayoutSubviews() {
        guard let imageView = imageView else {
            super.viewDidLayoutSubviews()
            return
        }
        // Adjust title if image size has changed
        if previousImgViewSize != imageView.bounds.size {
            previousImgViewSize = imageView.bounds.size
            adjustTitle(for: imageView)
        }
        // Position `imageView`
        let linesCount = newLinesCount(for: imageView)
        let padding = Constants.padding(for: preferredStyle)
        imageView.center.x = view.bounds.width / 2.0
        imageView.center.y = padding + linesCount * lineHeight / 2.0
        super.viewDidLayoutSubviews()
    }
    
    /// Adds appropriate number of "\n" to `title` text to make space for `imageView`
    private func adjustTitle(for imageView: UIImageView) {
        let linesCount = Int(newLinesCount(for: imageView))
        let lines = (0..<linesCount).map({ _ in "\n" }).reduce("", +)
        spaceAdjustedTitle = lines + (originalTitle ?? "")
        title = spaceAdjustedTitle
    }
    
    /// - Return: Number new line chars needed to make enough space for `imageView`
    private func newLinesCount(for imageView: UIImageView) -> CGFloat {
        return ceil(imageView.bounds.height / lineHeight)
    }
    
    /// Calculated based on system font line height
    private lazy var lineHeight: CGFloat = {
        let style: UIFont.TextStyle = self.preferredStyle == .alert ? .headline : .callout
        return UIFont.preferredFont(forTextStyle: style).pointSize
    }()
    
    struct Constants {
        static var paddingAlert: CGFloat = 22
        static var paddingSheet: CGFloat = 11
        static func padding(for style: UIAlertController.Style) -> CGFloat {
            return style == .alert ? Constants.paddingAlert : Constants.paddingSheet
        }
    }

}

extension UIViewController{
    
    
    func showAlert(title:String, msg:String){
        DispatchQueue.main.async {
            let alertVc = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertVc.addAction(action)
            self.present(alertVc, animated: true, completion: nil)
        }
       
    }
    
    func showFancyAlert(title: String, msg : String, icon : String){
         DispatchQueue.main.async {
            let alertVc = FancyAlertController(title: title, message: msg, preferredStyle: .alert)
            let image = UIImage(named: icon)
            alertVc.setTitleImage(image)
            
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertVc.addAction(action)
            self.present(alertVc, animated: true, completion: nil)
        }
    }
    
    func hideNavBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavBar(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
