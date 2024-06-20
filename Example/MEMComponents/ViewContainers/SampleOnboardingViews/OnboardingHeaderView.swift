//
//  OnboardingHeaderView.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 17/06/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MEMBase
import Kingfisher
import MEMComponents

class OnboardingHeaderView: MCBaseSectionView {

    let fontManager = MEMComponentFontStylesManager()
    
    lazy var titleLbl: UILabel = {
        let label = UILabel.newSet()
        label.textColor = .black
        label.font =  fontManager.light(size: MEMBaseFontSizes.titleXL)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var headerImage: UIImageView = .newSet()
    
    convenience init(data: String, parent: MEMBaseViewController) {
        self.init()
    }
    
    override init() {
        super.init()
        setHeaderImage()
        setTitle()
    }

    private func setHeaderImage() {
        headerImage.contentMode = .scaleAspectFit
        headerImage.setDimension(dimension: .height, value: 200)
        headerImage.kf.indicatorType = .activity
        headerImage.kf.setImage(with: URL(string: "https://i.pinimg.com/originals/3b/20/11/3b20112f0f7ae4bc678cfc2b7fbc40b1.jpg"))
        
        self.add(view: headerImage)
    }
    
    func setTitle() {
        titleLbl.text = "This is going to be an awesome intro"
        titleLbl.sizeToFit()
        titleLbl.isUserInteractionEnabled = true
        // TODO: Update MEMBase then this is going to work
        /*titleLbl.addTapGestureRecognizer {
            print("Tapped text")
        }*/
        
        self.add(view: titleLbl)
    }
    

}
