//
//  MCFixedContainer.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 17/06/24.
//

import Foundation
import MEMBase
import UIKit

internal class MCFixedContainer {
    
    struct Constants {
        static var stackSpacing = 10.0
        static let itemContainerSideMargin = 10.0
        static let itemContainerHeight = 50.0
    }
    
    private var parentWidth: CGFloat = 0.0
    private var parentHeight: CGFloat = 0.0
    private var mainContainer: UIView = .newSet()
    
    // MARK: - Optionals
    public var headerSection: MCBaseSectionView?
    public var bodySection: MCBaseSectionView?
    public var footerSection: MCBaseSectionView?
    public var aboveView: UIView?
    
    // MARK: - Mandatory
    private var direction: ScrollContainerDirection
    private var parent: UIView
    
    
    public init(direction: ScrollContainerDirection, parent: UIView) {
        self.direction = direction
        self.parent = parent
        updateDimensions()
    }
    
    private func updateDimensions() {
        parentWidth = parent.frame.size.width
        parentHeight = parent.frame.size.height
    }
    
    /**
     * Attach the view into the parent view ( left, top, right )
     * - parameters parent: The parent view which is goint to add the child view
     * - parameters below: The view whic the child view is goind to attach from the bottom
     */
    public func bind() {
        setContainer()
        update()
    }
    
    private func setContainer() {
        parent.addSubview(mainContainer)
        
        if let aboveView = aboveView {
            mainContainer.hook(.top, to: .bottom, of: aboveView)
        } else {
            mainContainer.hookSafeArea(.top, to: .top, of: parent, valueInset: 5.0)
        }
        
        mainContainer.hook(.left, to: .left, of: parent)
        mainContainer.hook(.right, to: .right, of: parent)
        mainContainer.hookParentView(toSafeArea: .bottom, valueInset: 1)
    }
    
    private func update() {
        setHeaderSection()
        setBodySection()
        setFooterSection()
        
        setAllConstraints()
    }
    
    private func setAllConstraints() {
        if let headerSection = headerSection {
            setHeaderConstraints(header: headerSection)
        }
        
        if let bodySection = bodySection {
            setBodyConstraints(body: bodySection)
        }
        
        if let footerSection = footerSection {
            setFooterConstraints(footer: footerSection)
        }
    }
    
    private func setHeaderSection() {
        if let headerSection = headerSection {
            mainContainer.addSubview(headerSection.getView())
        }
    }
    
    private func setHeaderConstraints(header: MCBaseSectionView) {
        header.getView().hook(.top, to: .top, of: mainContainer)
        header.getView().hook(.left, to: .left, of: mainContainer)
        header.getView().hook(.right, to: .right, of: mainContainer)
    }
    
    private func setBodySection() {
        if let bodySection = bodySection {
            mainContainer.addSubview(bodySection.getView())
        }
    }
    
    private func setBodyConstraints(body: MCBaseSectionView) {
        body.getView().hook(.left, to: .left, of: mainContainer)
        body.getView().hook(.right, to: .right, of: mainContainer)
        
        if let headerSection = headerSection {
            body.getView().hook(.top, to: .bottom, of: headerSection.getView(), valueInset: body.getTopSpacing())
        } else if headerSection == nil, let footerSection = footerSection {
            body.getView().hook(.bottom, to: .top, of: footerSection.getView())
        } else if footerSection == nil, let headerSection = headerSection {
            body.getView().hook(.top, to: .bottom, of: headerSection.getView(), valueInset: body.getTopSpacing())
        } else if headerSection == nil && footerSection == nil {
            body.getView().hookAxis(.vertical, sameOf: mainContainer)
            body.getView().hookAxis(.horizontal, sameOf: mainContainer)
        }
    }
    
    private func setFooterSection() {
        if let footerSection = footerSection {
            mainContainer.addSubview(footerSection.getView())
        }
    }
    
    private func setFooterConstraints(footer: MCBaseSectionView) {
        footer.getView().hook(.bottom, to: .bottom, of: mainContainer)
        footer.getView().hook(.left, to: .left, of: mainContainer)
        footer.getView().hook(.right, to: .right, of: mainContainer)
    }
    
}
