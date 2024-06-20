//
//  DeeplinkCell.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 28/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MEMBase

class DeeplinkCell: UITableViewCell {
    
    let fontManager = MEMComponentFontStylesManager()
    
    lazy var titleLbl: UILabel = {
        let label = UILabel.newSet()
        label.textColor = .darkGray
        label.font =  fontManager.light(size: MEMBaseFontSizes.bodyM)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = .lightGray.withAlphaComponent(0.2)
        self.selectionStyle = .none
        contentView.addSubview(titleLbl)
        
        titleLbl.hook(.left, to: .left, of: contentView, valueInset: 10)
        titleLbl.hook(.right, to: .right, of: contentView, valueInset: -10)
        titleLbl.hook(.top, to: .top, of: contentView)
        titleLbl.hook(.bottom, to: .bottom, of: contentView)
    }
    
    func set(data: SectionExample) {
        titleLbl.text = data.title
    }
    
}
