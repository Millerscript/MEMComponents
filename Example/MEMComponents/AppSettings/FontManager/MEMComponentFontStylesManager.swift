//
//  MEMComponentFontStylesManager.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 5/06/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase
import UIKit

class MEMComponentFontStylesManager: MEMBaseFontStyles {
    init() {}
    
    func regular(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Regular", size: size)
    }
    
    func medium(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Medium", size: size)
    }
    
    func thin(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Thin", size: size)
    }
    
    func light(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Light", size: size)
    }
    
    func italic(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Italic", size: size)
    }
    
    func semibold(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-SemiBold", size: size)
    }
    
    func bold(size: CGFloat) -> UIFont? {
        return UIFont(name: "Poppins-Bold", size: size)
    }
}
