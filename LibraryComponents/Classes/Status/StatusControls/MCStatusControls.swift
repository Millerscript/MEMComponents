//
//  MCStatusControls.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 26/05/24.
//

import Foundation
import UIKit
import MEMBase

public protocol MCStatusStoriesControls {
    var leftAction: (() -> Void)? { get set }
    var rightAction: (() -> Void)? { get set }
    func attach(parentView: UIView)
    func getView() -> UIView
}

public class MCStatusControls: NSObject, MCStatusStoriesControls {
        
    struct Constants {
        static let containerHeight: CGFloat = 300
        static let sideButtonsWDimension: CGFloat = 100
        static let sideButtonsHDimension: CGFloat = 300
    }
    
    public var leftAction: (() -> Void)?
    public var rightAction: (() -> Void)?

    private var containerView: UIView = .newSet()
    
    let leftControl: UIView = {
        let view = UIView.newSet()
        view.backgroundColor = .clear
        return view
    }()
    
    let rightControl: UIView = {
        let view = UIView.newSet()
        view.backgroundColor = .clear
        return view
    }()
    
    public override init() {
        containerView.backgroundColor = .clear
        super.init()
        self.addControlsHierarchy()
        self.setConstraints()
        self.setEvents()
    }
    
    public func attach(parentView: UIView) {
        parentView.addSubview(containerView)
        containerView.hookAxis(.vertical, sameOf: parentView)
        containerView.hook(.left, to: .left, of: parentView)
        containerView.hook(.right, to: .right, of: parentView)
        containerView.setDimension(dimension: .height, value: Constants.containerHeight)
    }
    
    private func addControlsHierarchy() {
        containerView.addSubview(leftControl)
        containerView.addSubview(rightControl)
    }
    
    private func setConstraints() {
        leftControl.hook(.left, to: .left, of: containerView)
        leftControl.setDimension(dimension: .height, value: Constants.sideButtonsHDimension)
        leftControl.setDimension(dimension: .width, value: Constants.sideButtonsWDimension)
        leftControl.hookAxis(.vertical, sameOf: containerView)
        
        rightControl.hook(.right, to: .right, of: containerView)
        rightControl.setDimension(dimension: .height, value: Constants.sideButtonsHDimension)
        rightControl.setDimension(dimension: .width, value: Constants.sideButtonsWDimension)
        rightControl.hookAxis(.vertical, sameOf: containerView)
    }
    
    private func setEvents() {
        setLeftActionTap()
        setRightActionTap()
    }
    
    private func setLeftActionTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(leftTap))
        leftControl.isUserInteractionEnabled = true
        leftControl.addGestureRecognizer(tap)
    }
    
    private func setRightActionTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(rightTap))
        rightControl.isUserInteractionEnabled = true
        rightControl.addGestureRecognizer(tap)
    }
    
    @objc func leftTap() {
        guard let leftAction else { return }
        leftAction()
    }
    
    @objc func rightTap() {
        guard let rightAction else { return }
        rightAction()
    }
    public func getView() -> UIView {
        return self.containerView
    }
    
}
