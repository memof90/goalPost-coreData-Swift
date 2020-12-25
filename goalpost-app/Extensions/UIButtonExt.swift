//
//  UIButtonExt.swift
//  goalpost-app
//
//  Created by Memo Figueredo on 25/12/20.
//

import UIKit


extension UIButton {
    func setSelectedColor(){
        self.backgroundColor = #colorLiteral(red: 0.4156862745, green: 0.7411764706, blue: 0.3725490196, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.6941176471, green: 0.8705882353, blue: 0.6784313725, alpha: 1)
    }
}
