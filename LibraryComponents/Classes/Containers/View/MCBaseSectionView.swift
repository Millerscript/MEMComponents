//
//  MCBaseSectionView.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 18/06/24.
//

import Foundation
import MEMBase
import UIKit

open class MCBaseSectionView: NSObject {
    
    struct Constants {
        static var stackSpacing = 10.0
    }
    
    private var mainView: UIView = .newSet()
    
    private var TOP_SPACING: CGFloat = 0.0
    private var BOTTOM_SPACING: CGFloat = 0.0
    
    private let viewsContainer: UIStackView = {
        let stackView = UIStackView.newSet()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = Constants.stackSpacing
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    public override init() {
        super.init()
        setViews()
    }
    
    private func setViews() {
        mainView.addSubview(viewsContainer)
        viewsContainer.hookToParentView()
    }
    
    public func add(view: UIView) {
        viewsContainer.addArrangedSubview(setConstraintsWithinWrapView(view: view))
    }
    
    public func add(view: UIView, insets: UIEdgeInsets) {
        viewsContainer.addArrangedSubview(setConstraintsWithinWrapView(view: view, insets: insets))
    }
    
    private func setConstraintsWithinWrapView(view: UIView, insets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)) -> UIView {
        let wrapView: UIView = .newSet()
        wrapView.addSubview(view)
        view.hook(.left, to: .left, of: wrapView, valueInset: insets.left)
        view.hook(.right, to: .right, of: wrapView, valueInset: insets.right)
        view.hook(.top, to: .top, of: wrapView, valueInset: insets.top)
        view.hook(.bottom, to: .bottom, of: wrapView, valueInset: insets.bottom)
        return wrapView
    }
    
    internal func getView() -> UIView {
        mainView.setNeedsLayout()
        mainView.layoutIfNeeded()
        return mainView
    }
    
    internal func getViewHeight() -> CGFloat {
        mainView.setNeedsLayout()
        mainView.layoutIfNeeded()
        print(mainView.frame.size.height.rounded())
        return mainView.frame.size.height.rounded()
    }
    
    public func setTopSpacing(spacing: CGFloat) {
        self.TOP_SPACING = spacing
    }
    
    public func setBottomSpacing(spacing: CGFloat) {
        self.BOTTOM_SPACING = spacing
    }
    
    internal func getTopSpacing() -> CGFloat {
        return TOP_SPACING
    }
    
    internal func getBottomSpacing() -> CGFloat {
        return BOTTOM_SPACING
    }
}
