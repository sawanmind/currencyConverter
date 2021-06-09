//
//  App + Utils.swift
//  PayPayAssignment
//
//  Created by Sawan Kumar on 08/06/21.
//

import Foundation
import UIKit

extension UITextField {
    func addKeyboardManager(_ action:Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.frame.size.height/6, width: self.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.default
        toolBar.tintColor = UIColor.black
        toolBar.backgroundColor = UIColor.systemGroupedBackground
        toolBar.setShadowImage(UIImage(), forToolbarPosition: .any)
        toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        
        let img = UIImage(named: "keyboard")
        let doneButton = UIBarButtonItem(image: img, style: .plain, target: target, action: action)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        toolBar.setItems([flexSpace,doneButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}

func dismissKeyboard() {
    UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder),to: nil, from: nil, for: nil)
}

extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}

extension String {
    func customize(color: UIColor, font:UIFont? = nil) -> NSMutableAttributedString {
        if font != nil {
            return NSMutableAttributedString(string: self, attributes:[NSAttributedString.Key.foregroundColor : color , NSAttributedString.Key.font:font as Any])
            
        }else {
            return NSMutableAttributedString(string: self, attributes:
                [NSAttributedString.Key.foregroundColor : color])
        }
        
    }
}
