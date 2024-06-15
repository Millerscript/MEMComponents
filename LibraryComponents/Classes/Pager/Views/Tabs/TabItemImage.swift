//
//  TabItemImage.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 27/03/24.
//

import Foundation
import UIKit
import MEMBase
import Combine

class TabItemImage: UIView, TabProtocol {
    
    struct Constants {
        static let titleSideMargin = 10.0
        static let imageDimention = 22.0
        static let cornerRadius = 10.0
    }
    
    var configuration: MCTabViewConfiguration
    var index: Int = 0
    var action = PassthroughSubject<TabData, Never>()
    var selected: Bool = false {
        didSet {
            self.backgroundColor = (selected) ? configuration.itemSelectedBackground : configuration.itemBackground
            self.tabItemTitle.updateStyle(selected: selected)
        }
    }
    
    var tabItemTitle: TabItemTitle
    
    required init(configuration: MCTabViewConfiguration) {
        self.configuration = configuration
        tabItemTitle = TabItemTitle(type: .IMAGE, configuration: configuration)
        super.init(frame: CGRect())
        defaultSettings()
    }
    
    init() {
        self.configuration = MCTabViewConfiguration(itemBackground: .gray.withAlphaComponent(0.3),
                                                    itemSelectedBackground: .gray.withAlphaComponent(0.3),
                                                    fontColor: .black,
                                                    fontSelectedColor: .white)
        tabItemTitle = TabItemTitle(type: .IMAGE, configuration: configuration)
        super.init(frame: CGRect())
        
        self.prepareForHooks()
        defaultSettings()
    }
    
    private func defaultSettings() {
        self.addSubview(tabItemTitle)
        self.clipsToBounds = true
        self.layer.cornerRadius = Constants.cornerRadius
        self.backgroundColor = configuration.itemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func create() -> Self {
        return self
    }
    
    func set(data: MCTabItemModel) {
        setTitle(image: data.icon!)
    }
    
    private func setTitle(image: UIImage) {
        tabItemTitle.bind()
        self.tabItemTitle.setData(icon: image)
        self.tabItemTitle.action = { [self] in
            action.send(TabData(index: index, type: .IMAGE))
        }
    }

}
