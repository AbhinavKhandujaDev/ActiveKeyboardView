//
//  ActiveKeyboardView.swift
//  ActiveKeyboardView
//
//  Created by abhinav khanduja on 11/09/19.
//  Copyright © 2019 abhinav khanduja. All rights reserved.
//

import Foundation
import UIKit

class ActiveKeyboardView: UIView {
    
    var distanceBetweenViewAndKeyboard : CGFloat = 10
    
    private var viewOriginalYPoint : CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpKeyboardObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpKeyboardObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setUpKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleKeyboardWillShow(notification:NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        
        viewOriginalYPoint = self.frame.origin.y
        let viewsBottomPoint = self.frame.origin.y + self.frame.height
        let keyboardTop = keyboardFrame.origin.y
        
        if keyboardTop < viewsBottomPoint {
            self.frame.origin.y -= (abs(viewsBottomPoint-keyboardTop) + distanceBetweenViewAndKeyboard)
        }
    }
    
    @objc private func handleKeyboardWillHide(notification:NSNotification) {
        guard let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        
        UIView.animate(withDuration: keyboardAnimationDuration) { [weak self] in
            self?.frame.origin.y = (self?.viewOriginalYPoint)!
        }
    }
}
