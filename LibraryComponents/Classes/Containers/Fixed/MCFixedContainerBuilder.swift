//
//  MCFixedContainerBuilder.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 17/06/24.
//

import Foundation

public enum ContainerType {
    case Scroll
    case Fixed
}

public class MCFixedContainerBuilder {
    
    let direction: ScrollContainerDirection
    var fixedContainer: MCFixedContainer
    
    public init( direction: ScrollContainerDirection, parent: UIView ) {
        self.direction = direction
        fixedContainer = MCFixedContainer(direction: direction, parent: parent)
    }
    
    public func setAboveView(uiView: UIView?) -> Self {
        fixedContainer.aboveView = uiView
        return self
    }
    
    public func setHeader(view: MCBaseSectionView?) -> Self {
        fixedContainer.headerSection = view
        return self
    }

    public func setBody(view: MCBaseSectionView?) -> Self {
        fixedContainer.bodySection = view
        return self
    }
    
    public func setFooter(uiView: MCBaseSectionView?) -> Self {
        fixedContainer.footerSection = uiView
        return self
    }
    
    public func build() {
        fixedContainer.bind()
    }
    
}
