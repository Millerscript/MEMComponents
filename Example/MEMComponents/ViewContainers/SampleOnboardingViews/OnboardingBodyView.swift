//
//  OnboardingBodyView.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 17/06/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MEMBase
import MEMComponents

class OnboardingBodyView: MCBaseSectionView {
    
    let fontManager = MEMComponentFontStylesManager()
    
    lazy var titleLbl: UILabel = {
        let label = UILabel.newSet()
        label.textColor = .darkGray
        label.font =  fontManager.light(size: MEMBaseFontSizes.titleM)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var tyc: UILabel = {
        let label = UILabel.newSet()
        label.textColor = .black
        label.font =  fontManager.light(size: MEMBaseFontSizes.titleS)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let withGoogleBtn: UIButton = {
        let button = UIButton.newSet()
        button.backgroundColor = .gray.withAlphaComponent(0.1)
        button.setTitle("With Google", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    let createAccountBtn: UIButton = {
        let button = UIButton.newSet()
        button.backgroundColor = .gray.withAlphaComponent(0.1)
        button.setTitle("Create an account", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    override init() {
        super.init()
        setArrangeViews()
    }
 
    private func setArrangeViews() {
        self.setTopSpacing(spacing: 70)
        setGoogleButton()
        setSeparatorText()
        setCreateAccountButton()
        setReadTermAndConditions()
    }
    
    private func setGoogleButton() {
        withGoogleBtn.setDimension(dimension: .height, value: 60)
        self.add(view: withGoogleBtn, insets: UIEdgeInsets(top: 0.0, left: 20, bottom: 0.0, right: -20))
    }
    
    private func setCreateAccountButton() {
        createAccountBtn.setDimension(dimension: .height, value: 60)
        self.add(view: createAccountBtn, insets: UIEdgeInsets(top: 0.0, left: 20, bottom: 0.0, right: -20))
    }
    
    private func setSeparatorText() {
        titleLbl.text = "Or"
        titleLbl.sizeToFit()

        self.add(view:titleLbl)
    }
    
    private func setReadTermAndConditions() {
        tyc.text = "Read our terms and conditions"
        tyc.sizeToFit()
        self.add(view: tyc)
    }
    
}
