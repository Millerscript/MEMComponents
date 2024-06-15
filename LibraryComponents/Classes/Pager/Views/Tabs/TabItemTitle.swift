//
//  TabItemTitle.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 29/03/24.
//

import Foundation
import UIKit
import MEMBase

internal class TabItemTitle: UIView {
    
    var action: (() -> Void)?
    
    struct Constants {
        static let titleSideMargin = 10.0
        static let imageDimention = 22.0
        static let cornerRadius = 10.0
    }
    private var configuration: MCTabViewConfiguration
    
    private lazy var title: UILabel = {
        let label = UILabel.newSet()
        label.textColor = configuration.fontColor
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView.newSet()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = configuration.fontColor
        return image
    }()
    
    private var type: TabStyle
    
    required init(type: TabStyle, configuration: MCTabViewConfiguration) {
        self.configuration = configuration
        self.type = type
        super.init(frame: CGRect())
        self.prepareForHooks()
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind() {
        guard let superview = self.superview else {return}
        
        self.hook(.top, to: .top, of: superview)
        self.hook(.left, to: .left, of: superview, valueInset: 6)
        self.hook(.right, to: .right, of: superview, valueInset: -6)
        self.hook(.bottom, to: .bottom, of: superview)
    }
    
    private func set() {
        switch type {
        case .TEXT:
            constraintsForText()
        case .IMAGE:
            constraintsForImage()
        case .COMPOUSE:
            constraintsForCompouse()
        }
        setEvent()
    }
    
    private func constraintsForText() {
        self.addSubview(title)
        title.hook(.top, to: .top, of: self)
        title.hook(.left, to: .left, of: self, valueInset: 6)
        title.hook(.right, to: .right, of: self, valueInset: -6)
        title.hook(.bottom, to: .bottom, of: self)
    }
    
    private func constraintsForImage() {
        self.addSubview(image)
        image.hook(.left, to: .left, of: self, valueInset: Constants.titleSideMargin)
        image.hook(.right, to: .right, of: self, valueInset: -Constants.titleSideMargin)
        image.hookAxis(.vertical, sameOf: self)
        image.hookAxis(.horizontal, sameOf: self)
        image.setDimension(dimension: .width, value: Constants.imageDimention)
        image.setDimension(dimension: .height, value: Constants.imageDimention)
    }
    
    private func constraintsForCompouse() {
        self.addSubview(title)
        self.addSubview(image)
        image.hook(.left, to: .left, of: self, valueInset: 6)
        image.hookAxis(.vertical, sameOf: self)
        image.setDimension(dimension: .width, value: Constants.imageDimention)
        image.setDimension(dimension: .height, value: Constants.imageDimention)
        
        title.hook(.top, to: .top, of: self)
        title.hook(.left, to: .right, of: image, valueInset: Constants.titleSideMargin)
        title.hook(.right, to: .right, of: self, valueInset: -Constants.titleSideMargin)
        title.hook(.bottom, to: .bottom, of: self)
    }
    
    public func setData(text: String? = nil, icon: UIImage? = nil) {
        if let text = text, let icon = icon {
            title.text = text
            image.image = icon
        } else if text != nil && icon == nil {
            title.text = text
        } else if text == nil && icon != nil {
            image.image = icon
        }
    }
    
    public func updateStyle(selected: Bool) {
        switchTitle(selected: selected)
        switchImage(selected: selected)
    }
    
    private func switchTitle(selected: Bool) {
        if type == .TEXT || type == .COMPOUSE {
            self.title.textColor = (selected) ? configuration.fontSelectedColor : configuration.fontColor
        }
    }
    
    private func switchImage(selected: Bool) {
        if type == .IMAGE || type == .COMPOUSE {
            self.image.tintColor = (selected) ? configuration.fontSelectedColor : configuration.fontColor
        }
    }
    
    private func setEvent() {
        let customTab = UITapGestureRecognizer(target: self, action: #selector(tab))
        self.addGestureRecognizer(customTab)
    }
    
    @objc func tab() {
        if let action = action {
            action()
        }
    }
    
}
