//
//  PagerIndexViewController.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 26/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase
import MEMComponents

class PagerIndexViewController: MEMBaseViewController {
    
    var pageViewController: MCPageIndexControl?
    var pages: [MEMBaseViewController] = []
    
    
    deinit {
        print("PagerViewController has been deinitilized")
    }

    private let inputIndex: UITextField = {
        let input = UITextField().newSet()
        input.placeholder = "Index..."
        input.textColor = .black
        input.backgroundColor = .darkGray.withAlphaComponent(0.4)
        return input
    }()
    
    private let btnForward: UIButton = {
        let button = UIButton().newSet()
        button.setTitle("Go to index", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray.withAlphaComponent(0.3)
        return button
    }()

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

        setTextInput()
        setButton()
        setupPageController()
    }
    
    private func setupPageController() {
        pages.append(ItemViewController(data: ["index":1, "data":"MC1"]))
        pages.append(ItemViewController(data: ["index":2, "data":"MC2"]))
        pages.append(ItemViewController(data: ["index":3, "data":"MC3"]))
        pages.append(ItemViewController(data: ["index":4, "data":"MC4"]))
        
        
        pageViewController = MCPageIndexControl(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController?.pageDelegate = self
        pageViewController?.pages.append(contentsOf: pages)
        pageViewController?.view.newSet()

        addChild(pageViewController!)
        self.view.addSubview(pageViewController!.view)

        pageViewController?.bind(to: self.view, topView: btnForward)
    }
    
    private func setTextInput() {
        self.view.addSubview(inputIndex)
        inputIndex.hook(.top, to: .top, of: self.view, valueInset: 100)
        inputIndex.hookAxis(.horizontal, sameOf: self.view)
        inputIndex.setDimension(dimension: .width, value: 50)
    }
    
    private func setButton() {
        self.view.addSubview(btnForward)
        btnForward.hook(.top, to: .bottom, of: inputIndex, valueInset: 6)
        btnForward.hookAxis(.horizontal, sameOf: inputIndex)
        btnForward.setDimension(dimension: .width, value: 100)
        
        btnForward.addTarget(self, action: #selector(moveView), for: .touchDown)
    }
    
    @objc func moveView() {
        let index = Int(inputIndex.text ?? "0") ?? 0
        pageViewController?.moveTo(index: index)
    }
}

extension PagerIndexViewController: MCPageDelegate {
    func move(index: Int) {
        print(index)
    }
}
