//
//  UIColor+Extension.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 12/30/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import UIKit

//Mark: - UIColor
extension UIColor {
    
    //Override super init to create out own convenience init.
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    //Secondary Color -> Blue
    static var lightBlue: UIColor { return UIColor(red: 18, green: 149, blue: 232) }
}

//Mark: - Int
extension Int {
    func doTask(_ task: (Int) -> Void) {
        for index in 0..<self {
            task(index)
        }
    }
 }

//Mark: - UITextField
extension UITextView {
    //Attributed string for the title, price and rating Icon
    func attributedFor(_ title: String, price: String, details:String? = nil) {
        guard   let textFont = UIFont(name: "Helvetica", size: 15) else { return }
        let attributedFont: Dictionary<NSAttributedStringKey, UIFont> = [.font :   textFont]
        
        let attributedText = NSMutableAttributedString(string: "\(title)\n", //Initialize Merch Details
            attributes: attributedFont)
        let priceAttributedString =  NSMutableAttributedString(string: "\n\(price)\n\n", //Price
            attributes: [.font: UIFont.boldSystemFont(ofSize: 15)])
        
        let ratingImage = NSTextAttachment()
            ratingImage.image = UIImage(named: "fiveStars") //Rating Icons
        let ratingAttributedString = NSAttributedString(attachment: ratingImage)
        
        //Appending the attributes
        attributedText.append(ratingAttributedString)
        attributedText.append(priceAttributedString)
        self.attributedText = attributedText
        
        guard   let itemDetail = details else { return }
                let attributedDetailsText = NSMutableAttributedString(string: itemDetail, //Initialize Merch Details
            attributes: attributedFont)
        
        attributedText.append(attributedDetailsText)
        self.attributedText = attributedText
    }
}

//Mark: - UIButton {
extension UIButton {
    convenience init(title: Menu.Options, imageName: String? = nil) {
        self.init(frame: .zero)
        let image = imageName == nil ? nil : UIImage(named: imageName!)
        setTitle(title.title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15)
        setImage(image, for: .normal)
        setTitleColor(.darkText , for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

