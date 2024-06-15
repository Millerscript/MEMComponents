//
//  HeaderViewCell.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 28/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MEMBase

class HeaderViewCell: UIView {
    
    let fontManager = MEMComponentFontStylesManager()
    
    lazy var titleLbl: UILabel = {
        let label = UILabel.newSet()
        label.text = ""
        label.textColor = .black
        label.font = fontManager.bold(size: MEMBaseFontSizes.titleS)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitle() {
        self.addSubview(titleLbl)
        
        titleLbl.hookingToParentView()
    }
    
    public func setTitle(text: String) {
        titleLbl.text = text
    }
}
