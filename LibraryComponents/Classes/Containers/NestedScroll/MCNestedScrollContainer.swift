//
//  MCNestedScrollContainer.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 17/06/24.
//

import Foundation
import MEMBase
import UIKit

public class MCNestedScrollContainer {
    
    struct Constants {
        static var scrollHeight = 50.0
        static var stackSpacing = 10.0
        static let itemContainerSideMargin = 10.0
        static let itemContainerHeight = 50.0
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.newSet()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    private let mainContainer: UIView = .newSet()
    
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
    
    private var parentWidth: CGFloat = 0.0
    private var direction: ScrollContainerDirection
    
    public init(direction: ScrollContainerDirection) {
        self.direction = direction
    }
    
    /**
     * Attach the view into the parent view ( left, top, right )
     * - parameters parent: The parent view which is goint to add the child view
     */
    public func bind(into parent: UIView) {
        parentWidth = parent.frame.size.width
        
        setScroll(parent: parent)
        setMainContainer()
        
        setContainer()
    }
    
    /**
     * Attach the view into the parent view ( left, top, right )
     * - parameters parent: The parent view which is goint to add the child view
     * - parameters below: The view whic the child view is goind to attach from the bottom
     */
    public func bind(into parent: UIView, below: UIView) {
        setScroll(parent: parent)
        setContainer()
    }
    
    private func setScroll(parent: UIView, below: UIView? = nil) {
        parent.addSubview(scrollView)
        
        if let below = below {
            scrollView.hook(.top, to: .bottom, of: below, valueInset: 5.0)
        } else {
            scrollView.hookSafeArea(.top, to: .top, of: parent, valueInset: 5.0)
        }
        scrollView.hook(.left, to: .left, of: parent)
        scrollView.hook(.right, to: .right, of: parent)
        scrollView.hook(.bottom, to: .bottom, of: parent)
    }
    
    private func setMainContainer() {
        scrollView.addSubview(mainContainer)
        scrollView.setNeedsLayout()
        scrollView.layoutIfNeeded()
        mainContainer.setDimension(dimension: .width, value: scrollView.frame.size.width)
        mainContainer.hook(.top, to: .top, of: scrollView)
        mainContainer.hook(.left, to: .left, of: scrollView)
        mainContainer.hook(.right, to: .right, of: scrollView)
        mainContainer.hook(.bottom, to: .bottom, of: scrollView)
    }
    
    private func setContainer() {
        mainContainer.addSubview(viewsContainer)
        
        viewsContainer.hook(.top, to: .top, of: mainContainer)
        viewsContainer.hook(.left, to: .left, of: mainContainer)
        viewsContainer.hook(.right, to: .right, of: mainContainer)
        viewsContainer.hook(.bottom, to: .bottom, of: mainContainer)
    }

    public func add(view: MCBaseSectionView) {
        defer {
            mainContainer.updateHookFor(dimension: .height, value: viewsContainer.frame.size.height)
        }
        viewsContainer.addArrangedSubview(view.getView())
        viewsContainer.setNeedsLayout()
        viewsContainer.layoutIfNeeded()
    }
}
