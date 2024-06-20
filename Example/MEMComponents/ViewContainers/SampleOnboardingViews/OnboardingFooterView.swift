//
//  OnboardingFooterView.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 17/06/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MEMBase
import MEMComponents

class OnboardingFooterView: MCBaseSectionView {
    
    let fontManager = MEMComponentFontStylesManager()
    
    lazy var titleLbl: UILabel = {
        let label = UILabel.newSet()
        label.textColor = .darkGray
        label.font =  fontManager.light(size: MEMBaseFontSizes.bodyS)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init() {
        super.init()
        setArrangeViews()
    }
    
    private func setArrangeViews() {
        setViews()
    }
   
    private func setViews() {
        titleLbl.text = "Have an account already? Log in"
        titleLbl.sizeToFit()
        self.add(view: titleLbl, insets: UIEdgeInsets(top: 0.0, left: 50, bottom: 0.0, right: 50))
    }
 
}
