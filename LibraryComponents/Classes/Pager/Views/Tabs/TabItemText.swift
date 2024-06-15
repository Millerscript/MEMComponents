//
//  TabItemText.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 27/03/24.
//

import Foundation
import UIKit
import MEMBase
import Combine

class TabItemText: UIView, TabProtocol {
    
    var index: Int = 0
    var action = PassthroughSubject<TabData, Never>()
    var configuration: MCTabViewConfiguration
    
    var selected: Bool = false {
        didSet {
            self.backgroundColor = (selected) ? configuration.itemSelectedBackground : configuration.itemBackground
            self.tabItemTitle.updateStyle(selected: selected)
        }
    }
    
    var tabItemTitle: TabItemTitle

    required init(configuration: MCTabViewConfiguration) {
        self.configuration = configuration
        tabItemTitle = TabItemTitle(type: .TEXT, configuration: configuration)
        super.init(frame: CGRect())
        
        self.prepareForHooks()
        defaultSettings()
    }
    
    init() {
        self.configuration = MCTabViewConfiguration(itemBackground: .gray.withAlphaComponent(0.3),
                                                    itemSelectedBackground: .gray.withAlphaComponent(0.3),
                                                    fontColor: .black,
                                                    fontSelectedColor: .white)
        tabItemTitle = TabItemTitle(type: .TEXT, configuration: configuration)
        super.init(frame: CGRect())
        defaultSettings()
    }
    
    private func defaultSettings() {
        self.addSubview(tabItemTitle)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = configuration.itemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(data: MCTabItemModel) {
        setTitle(text: data.text)
    }
    
    private func setTitle(text: String) {
        tabItemTitle.bind()
        self.tabItemTitle.setData(text: text)
        self.tabItemTitle.action = { [self] in
            action.send(TabData(index: index, type: .TEXT))
        }
    }
    
    func create() -> Self {
        return self
    }

}
