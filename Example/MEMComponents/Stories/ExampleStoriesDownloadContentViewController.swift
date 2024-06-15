//
//  ExampleStoriesDownloadContentViewController.swift
//  MEMComponentsTests
//
//  Created by Miller Mosquera on 18/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase
import MEMComponents
import Combine

class ExampleStoriesDownloadContentViewController: MEMBaseViewController {
    
    let leftControl: UIView = {
        let view = UIView.newSet()
        view.backgroundColor = .yellow
        return view
    }()
    
    let rightControl: UIView = {
        let view = UIView.newSet()
        view.backgroundColor = .green
        return view
    }()
    
    let statusScreen = MCStatusScreen()
    var cancellable = [AnyCancellable]()
    
    deinit {
        print("ExampleStoriesDownloadContentViewController has been deinitialized")
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
        subscription()
        addHierarchy()
        setConstraints()
        setEvents()
    }
    
    private func addHierarchy() {
        self.view.addSubview(leftControl)
        self.view.addSubview(rightControl)
        
        statusScreen.add(parent: self.view)
        statusScreen.downloadImage(imageUrl: "https://i.pinimg.com/originals/a7/80/0b/a7800b5b967972b28d60b2a574a31326.jpg")
    }
    
    private func setConstraints() {
        leftControl.hook(.left, to: .left, of: self.view)
        leftControl.setDimension(dimension: .height, value: 50)
        leftControl.setDimension(dimension: .width, value: 50)
        leftControl.hookAxis(.vertical, sameOf: self.view)
        
        rightControl.hook(.right, to: .right, of: self.view)
        rightControl.setDimension(dimension: .height, value: 50)
        rightControl.setDimension(dimension: .width, value: 50)
        rightControl.hookAxis(.vertical, sameOf: self.view)
    }
    
    
    private func setEvents() {
        let leftTap = UITapGestureRecognizer(target: self, action: #selector(previousStory))
        leftControl.addGestureRecognizer(leftTap)
        
        let rightTap = UITapGestureRecognizer(target: self, action: #selector(nextStory))
        rightControl.addGestureRecognizer(rightTap)
    }
    
    @objc func nextStory() {
        
    }
    
    @objc func previousStory() {
        
    }

    func subscription() {
        statusScreen.subject.sink { error in
            print(error)
        } receiveValue: { _ in
            print("Image has been downloaded, now is showing up")
        }.store(in: &cancellable)
    }
    
}
