//
//  TabViewExampleViewController.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 27/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MEMBase
import MEMComponents

class TabViewExampleViewController: MEMBaseViewController {
    
    let tabView = MCTabView(scrollDirection: .HORIZONTAL)
    
    var lblTitle: UILabel = {
        let label = UILabel().newSet()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    required init(data: [String : Any]) {
        super.init(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.showNavigationBar()
        setTabView()
        setTitle()
    }
    
    private func setTitle() {
        self.view.addSubview(lblTitle)
        lblTitle.hook(.top, to: .bottom, of: self.tabView.getView(), valueInset: 30)
        lblTitle.hook(.left, to: .left, of: self.view)
        lblTitle.hook(.right, to: .right, of: self.view)
    }
    
    private func setTabView() {
        tabView.tabs.append(MCTabItemModel(itemId: 1, text: "", selected: false, icon: UIImage(systemName: "car")))
        tabView.tabs.append(MCTabItemModel(itemId: 2, text: "Summer", selected: true, icon: nil))
        tabView.tabs.append(MCTabItemModel(itemId: 3, text: "Miller Mosquera", selected: false, icon: UIImage(systemName: "eraser.line.dashed")))
        tabView.tabs.append(MCTabItemModel(itemId: 4, text: "Mazda", selected: false, icon: nil))
        tabView.tabs.append(MCTabItemModel(itemId: 5, text: "Toyota", selected: false, icon: nil))
        
        tabView.bind(parent: self.view)
        tabView.onItemTapped = { id in            
            let data = self.tabView[id]
            print("In the main thread: \(data.text)")
            self.lblTitle.text = data.text
        }
        self.view.layoutIfNeeded()
    }
}
