//
//  MCBarContainerNavigation.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 31/05/24.
//

import Foundation
import UIKit
import MEMBase

public protocol MCBarContainerNavigation: UIView {
    var backAction: (() -> Void)? { get set }
    var optionAction: (() -> Void)? { get set }
    
    func close()
    func goToProfile()
    func showOption()
}

public class MCStatusNavigation: UIView, MCBarContainerNavigation {
    
    public var backAction: (() -> Void)?
    public var optionAction: (() -> Void)?
    
    struct Constants {
        static let buttonDimension: CGFloat = 30
        static let backButtonIcon: String = "chevron.backward.circle.fill"
        static let optionButtonIcon: String = "ellipsis.circle.fill"
    }
    
    private let backButton: UIImageView = {
        let imageView = UIImageView.newSet()
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let optionButton: UIImageView = .newSet()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addHierarchy()
        setConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addHierarchy() {
        self.addSubview(backButton)
        self.addSubview(optionButton)
    }
    
    private func setConstraints() {
        backButton.hook(.left, to: .left, of: self)
        backButton.hookAxis(.vertical, sameOf: self)
        backButton.setDimension(dimension: .height, value: Constants.buttonDimension)
        backButton.setDimension(dimension: .width, value: Constants.buttonDimension)
        
        optionButton.hook(.right, to: .right, of: self)
        optionButton.hookAxis(.vertical, sameOf: self)
        optionButton.setDimension(dimension: .height, value: Constants.buttonDimension)
        optionButton.setDimension(dimension: .width, value: Constants.buttonDimension)
    }
    
    private func setupViews() {
        setBackButton()
        setOptionButton()
        setEvents()
    }
    
    private func setBackButton() {
        backButton.image = UIImage(systemName: Constants.backButtonIcon)
        backButton.tintColor = .white
    }
    
    private func setOptionButton() {
        optionButton.image = UIImage(systemName: Constants.optionButtonIcon)
        optionButton.tintColor = .white
    }
    
    private func setEvents() {
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backAct))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(backTap)
    }
    
    @objc func backAct() {
        print("Log: Action tapped")
        guard let backAction else { return }
        print("Log: Action tapped after validation")
        backAction()
    }
    
    public func close() {
        
    }
    
    public func goToProfile() {
        
    }
    
    public func showOption() {
        
    }
    
}
