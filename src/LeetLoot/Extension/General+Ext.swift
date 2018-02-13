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
    static var customGray: UIColor { return UIColor(red: 238, green: 239, blue: 241) }
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
    func attributedFor(_ title: String, condition: String, price: String, shipping: String, details:String? = nil) {
        
        guard   let textFont = UIFont(name: "Helvetica", size: 14) else { return }
        let attributedFont: Dictionary<NSAttributedStringKey, UIFont> = [.font :   textFont]
        let customText = title[0...30].appending("...")
        
        let attributedText = NSMutableAttributedString( string: "\(customText)\n", //Initialize Merch Details
                                                        attributes: attributedFont)
        
        let conditionAttributedString = NSMutableAttributedString(  string: "\(condition)\n\n", //Item Condition
                                                                    attributes: [.font: UIFont.systemFont(ofSize: 13),
                                                                                .foregroundColor: UIColor.lightGray])
        
        let priceAttributedString =  NSMutableAttributedString( string: "\(price)\n", //Price
                                                                attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        let shippingAttributedString = NSMutableAttributedString(  string: "\(shipping)\n\n", //Item Condition
                                                                   attributes: [.font: UIFont.systemFont(ofSize: 13),
                                                                                .foregroundColor: UIColor.lightGray])
        
        //Appending the attributes
        attributedText.append(conditionAttributedString)
        attributedText.append(priceAttributedString)
        attributedText.append(shippingAttributedString)
        self.attributedText = attributedText

        
        guard   let itemDetail = details else { return }
        let attributedDetailsText = NSMutableAttributedString(  string: itemDetail, //Initialize Merch Details
                                                                attributes: attributedFont)
        
        attributedText.append(attributedDetailsText)
        self.attributedText = attributedText
    }
}

//Mark: - UIButton {
extension UIButton {
    convenience init(title: String, imageName: String? = nil) {
        self.init(frame: .zero)
        let image = imageName == nil ? nil : UIImage(named: imageName!)
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15)
        setImage(image, for: .normal)
        setTitleColor(.darkText , for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

//Mark: - String {
extension String {
    subscript (r: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}

