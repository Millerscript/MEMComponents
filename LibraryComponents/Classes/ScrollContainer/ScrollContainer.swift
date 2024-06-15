//
//  ScrollContainer.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 27/03/24.
//

import Foundation
import MEMBase
import UIKit

public enum ScrollContainerDirection {
    case VERTICAL
    case HORIZONTAL
}


open class ScrollContainer {
    
    struct Constants {
        static var scrollHeight = 50.0
        static var stackSpacing = 10.0
        static let itemContainerSideMargin = 10.0
        static let itemContainerHeight = 50.0
    }
    
    private let itemsContainer: UIStackView = {
        let stackView = UIStackView.newSet()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = Constants.stackSpacing
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let sampleView: UIView = {
        let view = UIView.newSet()
        view.backgroundColor = .brown
        return view
    }()
    
    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.newSet()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addSubview(itemsContainer)
        return scrollView
    }()
    
    private var direction: ScrollContainerDirection
    
    init(direction: ScrollContainerDirection) {
        self.direction = direction
    }
    
    /**
     * Attach the view into the parent view ( left, top, right
     * - parameters parent: The parent view which is goint to add the child view
     */
    public func bind(into parent: UIView) {
        setScroll(parent: parent)
        setContainer()
    }
    
    /**
     * Attach the view into the parent view ( left, top, right
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
        scrollView.setDimension(dimension: .height, value: Constants.scrollHeight)
    }
    
    private func setContainer() {
        itemsContainer.hook(.left, to: .left, of: scrollView, valueInset: Constants.itemContainerSideMargin)
        itemsContainer.hook(.right, to: .right, of: scrollView, valueInset: -Constants.itemContainerSideMargin)
        itemsContainer.hookAxis(.vertical, sameOf: scrollView)
        itemsContainer.setDimension(dimension: .height, value: Constants.itemContainerHeight)
    }
    
    public func add(item: TabProtocol) {
        itemsContainer.addArrangedSubview(item)
    }
    
    public func getChild(index: Int) -> TabProtocol {
        return itemsContainer.subviews[index] as! TabProtocol
    }
    
    public func getChildren() -> [TabProtocol] {
        return (itemsContainer.subviews as? [TabProtocol])!
    }
    
    public subscript(_ index: Int) -> TabProtocol {
        return itemsContainer.subviews[index] as! TabProtocol
    }
}
