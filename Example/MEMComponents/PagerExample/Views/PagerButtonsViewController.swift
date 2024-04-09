//
//  PagerButtonsViewController.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 7/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase
import MEMComponents

class PagerButtonsViewController: MEMBaseViewController {
    
    var pageViewController: MCPageArrowControl?
    var pages: [MEMBaseViewController] = []
    
    deinit {
        print("PagerViewController has been deinitilized")
    }
    
    required init(data: [String : Any]) {
        super.init(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
        self.view.backgroundColor = .white
        setupPageController()
    }
    
    private func setupPageController() {
        pages.append(ItemViewController(data: ["index":1, "data":"MC1"]))
        pages.append(ItemViewController(data: ["index":2, "data":"MC2"]))
        pages.append(ItemViewController(data: ["index":3, "data":"MC3"]))
        pages.append(ItemViewController(data: ["index":4, "data":"MC4"]))
        
        
        pageViewController = MCPageArrowControl(transitionStyle: .scroll, navigationOrientation: .horizontal)
        //pageViewController?.pageDelegate = self
        pageViewController?.pages.append(contentsOf: pages)
        pageViewController?.view.newSet()

        addChild(pageViewController!)
        self.view.addSubview(pageViewController!.view)

        pageViewController?.bind(to: self.view)
    }
    
}
