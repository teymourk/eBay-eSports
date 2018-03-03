//
//  SiginIn.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/20/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class ParentModal: NSObject {
    
    enum PageAction {
        case open, close, login, signUp, none
    }
    
    lazy var signIn = { () -> SignIn in
        let view = SignIn(frame: signInFrames(self.edgeOffset, -(self.width)))
            view.backgroundColor = .white
        return view
    }()
    
    lazy var signUp = { () -> SignUp in
        let view = SignUp(frame: signUpInitialFrame(self.width, self.edgeOffset))
            view.backgroundColor = .white
        return view
    }()
    
    private lazy var fadeBackground = { ()-> UIView in
        let view = UIView(frame: window.frame)
            view.backgroundColor = .black
            view.alpha = 0
        return view
    }()
    
    private lazy var signInFrames: (CGFloat,CGFloat) -> CGRect = {
        return CGRect(x: $0,
                      y: $1 + self.topAnchor,
                      width: self.width - (self.edgeOffset * 2),
                      height: self.width - 20)
    }
    
    private lazy var signUpInitialFrame: (CGFloat,CGFloat) -> CGRect = {
        return CGRect(x: $0,
                      y: $1 + self.topAnchor,
                      width: self.width - (self.edgeOffset * 2),
                      height: self.width)
    }
    

    var topAnchor: CGFloat {
        get {
            let device = Constants.deviceType.None.isDevice()
            return device == .X ? 30 : 0
        }
    }
    
    var action: PageAction = .none {
        willSet {
            switch newValue {
            case .open:
                openLogin()
            case .signUp, .login:
                switchBetweenPages(newValue)
            case .close:
                closePage()
            case .none: return
            }
        }
    }
    
    private let edgeOffset: CGFloat = 8
    private let (window, width) =  (Constants.kWindow,
                                    Constants.kWidth)
    
    private func openLogin() {
        window.windowLevel = UIWindowLevelStatusBar
        window.addSubview(fadeBackground)
        window.addSubview(signIn)
        
        doSpringAnimation {
            self.fadeBackground.alpha = 0.5
            self.signIn.frame = self.signInFrames(self.edgeOffset, self.edgeOffset)
        }
    }
    
    private func closePage() {
    
        UIView.animate(withDuration: 0.3, animations: {
            self.fadeBackground.alpha = 0
            self.signUp.frame = self.signInFrames(self.signUp.frame.origin.x, -(self.width))
            self.signIn.frame = self.signInFrames(self.signIn.frame.origin.x, -(self.width))
    
        }, completion: { (true) in
            self.fadeBackground.removeFromSuperview()
            self.signIn.removeFromSuperview()
            self.signUp.removeFromSuperview()
            
            self.signIn.frame = self.signInFrames(self.edgeOffset, -(self.width))
            self.signUp.frame = self.signUpInitialFrame(self.width, self.edgeOffset)

        })
    }

    private func switchBetweenPages(_ page: PageAction) {
        if !self.signUp.isDescendant(of: window) { window.addSubview(signUp) }
    
        let moveFrame = page == .signUp ? self.signInFrames(-(self.width), self.edgeOffset) : self.signUpInitialFrame(self.width, self.edgeOffset),
            replaceFrame = page == .signUp ? self.signUpInitialFrame(self.edgeOffset, self.edgeOffset) : self.signInFrames(self.edgeOffset, self.edgeOffset)
        
        
        let viewToMove = page == .signUp ? signIn : signUp,
            viewToReplace = page == .signUp ? signUp : signIn
        
        self.doSpringAnimation {
            viewToMove.frame = moveFrame
            self.doSpringAnimation {
                viewToReplace.frame = replaceFrame
            }
        }
    }
    
    private func doSpringAnimation(_ animate: @escaping ()-> Void) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1,
                       options: .curveEaseOut, animations: {
                        animate()
        }, completion: nil)
    }
}
