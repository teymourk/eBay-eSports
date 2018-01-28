//
//  Constants.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/17/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

struct Constants {
    static var kWindow: UIWindow { return UIApplication.shared.keyWindow! }
    static var kWidth: CGFloat { return kWindow.frame.width }
    static var kHeight: CGFloat { return kWindow.frame.height }
    
    enum deviceType {
        case five, regular, plus, X, None
        
        func isDevice() -> deviceType {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    return .five
                case 1334:
                    return .regular
                case 2208:
                    return .plus
                case 2436:
                    return .X
                default:
                    print("unknown")
                }
            }
            return .None
        }
    }
}

