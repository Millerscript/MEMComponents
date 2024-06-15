//
//  TabViewPagerViewController.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 12/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase
import MEMComponents

class TabViewPagerViewController: MEMBaseViewController {
    
    let tabView = MCTabView(scrollDirection: .HORIZONTAL)
    var pageViewController: MCPageIndexControl?
    
    
    var pages: [MEMBaseViewController] = []
    
    
    deinit {
        print("TabViewPagerViewController has been de-initialized")
    }
    
    required init(data: [String : Any]) {
        super.init(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        showNavigationBar()
        setTabView()
        setupPageController()
    }
    
    private func setTabs() {
        tabView.tabs.append(MCTabItemModel(itemId: 0, text: "", selected: false, icon: UIImage(systemName: "car")))
        tabView.tabs.append(MCTabItemModel(itemId: 1, text: "Summer", selected: true, icon: nil))
        tabView.tabs.append(MCTabItemModel(itemId: 2, text: "Miller Mosquera", selected: false, icon: UIImage(systemName: "eraser.line.dashed")))
        tabView.tabs.append(MCTabItemModel(itemId: 3, text: "Mazda", selected: false, icon: nil))
        tabView.tabs.append(MCTabItemModel(itemId: 4, text: "Toyota", selected: false, icon: nil))
    }
    
    private func setTabView() {
        setTabs()
        tabView.bind(parent: self.view)
        tabView.onItemTapped = { [weak self] id in
            guard let self = self else {return}
            self.pageViewController?.moveTo(index: id)
        }
        
        self.view.layoutIfNeeded()
    }
    
    private func setPages() {
        pages.append(ItemViewController(data: ["index":1, "data":"MC1"]))
        pages.append(ItemViewController(data: ["index":2, "data":"MC2"]))
        pages.append(ItemViewController(data: ["index":3, "data":"MC3"]))
        pages.append(ItemViewController(data: ["index":4, "data":"MC4"]))
    }
    
    private func setupPageController() {
        setPages()
        pageViewController = MCPageIndexControl(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController?.pageDelegate = self
        pageViewController?.pages.append(contentsOf: pages)
        pageViewController?.view.prepareForHooks()

        addChild(pageViewController!)
        self.view.addSubview(pageViewController!.view)

        pageViewController?.bind(to: self.view, topView: tabView.getView())
    }
}

extension TabViewPagerViewController: MCPageDelegate {
    func move(index: Int) {
        print(index)
    }
}
