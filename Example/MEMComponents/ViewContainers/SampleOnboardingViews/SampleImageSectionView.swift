//
//  SampleImageSectionView.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 19/06/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MEMBase
import Kingfisher
import MEMComponents

class SampleImageSectionView: MCBaseSectionView {

    let fontManager = MEMComponentFontStylesManager()

    var headerImage: UIImageView = .newSet()
    
    convenience init(data: String, parent: MEMBaseViewController) {
        self.init()
    }
    
    override init() {
        super.init()
        setHeaderImage()
    }

    private func setHeaderImage() {
        headerImage.contentMode = .scaleToFill
        headerImage.setDimension(dimension: .height, value: 400)
        headerImage.kf.indicatorType = .activity
        headerImage.kf.setImage(with: URL(string: "https://i.pinimg.com/originals/b9/38/41/b9384103354d227583e71c346ff935a7.jpg"))
        
        self.add(view: headerImage)
    }
  
}
