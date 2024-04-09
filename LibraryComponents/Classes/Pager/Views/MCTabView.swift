//
//  MCTabView.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 26/03/24.
//

import Foundation
import UIKit
import MEMBase
import Combine

public class MCTabView: NSObject {
        
    private var scrollContainer: ScrollContainer
    public var tabs: [MCTabItemModel] = []
    public var onItemTapped: ((Int) -> Void)?
    private var cancellable = [AnyCancellable]()
    public var configuration: MCTabViewConfiguration = MCTabViewConfiguration(itemBackground: .gray.withAlphaComponent(0.3),
                                                                              itemSelectedBackground: .darkGray.withAlphaComponent(0.7),
                                                                              fontColor: .black,
                                                                              fontSelectedColor: .white)
    
    public init(scrollDirection: ScrollContainerDirection) {
        self.scrollContainer = ScrollContainer(direction: scrollDirection)
        super.init()
    }
    
    public func bind(parent view: UIView) {
        scrollContainer.bind(into: view)        
        setItems()
    }
    
    private func setItems() {        
        for (index, tabData) in tabs.enumerated() {
            
            var tabItemStyle: TabProtocol
            
            switch tabData.type {
            case .TEXT:
                tabItemStyle = TabItemText(configuration: configuration)
            case .IMAGE:
                tabItemStyle = TabItemImage(configuration: configuration)
            case .COMPOUSE:
                tabItemStyle = TabItemCompouse(configuration: configuration)
            }
            
            setTab(tab: tabItemStyle, data: tabData, index: index)
        }
    }
    
    private func setTab(tab: TabProtocol, data: MCTabItemModel, index: Int) {
        tab.set(data: data)
        tab.index = index
        tab.action.sink { [self] data in
            let child = scrollContainer[data.index]
            animateSelection(child: child)
            resetSelection()
            child.selected = true
            
            if let itemTapped = self.onItemTapped {
                itemTapped(data.index)
            }
            
        }.store(in: &cancellable)
        scrollContainer.add(item: tab.create())
    }
    
    private func animateSelection(child: UIView) {
      UIView.animate(withDuration: 0.3) {
          let selectedItemFrame = child.frame
          let scrollViewWidth = self.scrollContainer.scrollView.frame.size.width
          let scrollViewCenterX = (scrollViewWidth) / 2
          let contentOffsetX = selectedItemFrame.origin.x + selectedItemFrame.size.width / 2 - scrollViewCenterX
          
          let maxOffsetX = (self.scrollContainer.scrollView.contentSize.width) - (scrollViewWidth)
          let clampedOffsetX = max(0, min(contentOffsetX, maxOffsetX))
          
          self.scrollContainer.scrollView.setContentOffset(CGPoint(x: clampedOffsetX, y: 0), animated: true)
      }
    }
    
    private func resetSelection() {
        scrollContainer.getChildren().forEach { item in
            item.selected = false
        }
    }
    
    public func getView() -> UIView {
        return scrollContainer.scrollView
    }
    
    public subscript(_ index: Int) -> MCTabItemModel {
        return self.tabs[index]
    }
}

public struct MCTabViewConfiguration {
    var itemBackground: UIColor
    var itemSelectedBackground: UIColor
    var fontColor: UIColor
    var fontSelectedColor: UIColor
}
