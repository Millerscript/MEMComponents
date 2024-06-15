//
//  ExampleStoriesViewController.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 13/04/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase
import MEMComponents

class ExampleStoriesProgressBarsViewController: MEMBaseViewController {
    
    let progressBarContainer = MCBarsContainer()
    
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
    
    deinit {
        print("ExampleStoriesViewController has been deinitialized")
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
        
        setProgressBarsContainer()
        addControlsHierarchy()
        setConstraints()
        setEvents()
    }
    
    private func addControlsHierarchy() {
        self.view.addSubview(leftControl)
        self.view.addSubview(rightControl)
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

    private func setProgressBarsContainer() {
        progressBarContainer.attach(in: self.view, position: .TOP)
        progressBarContainer.setProgressBars(progressBars: [ProgressBarConfiguration(duration: 6, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .blue),
                                                            ProgressBarConfiguration(duration: 2, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .cyan),
                                                            ProgressBarConfiguration(duration: 1, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .green),
                                                            ProgressBarConfiguration(duration: 4, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .orange),
                                                            ProgressBarConfiguration(duration: 3, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .red)])
        
        progressBarContainer.start()
    }
    
    private func setEvents() {
        let leftTap = UITapGestureRecognizer(target: self, action: #selector(previousStory))
        leftControl.addGestureRecognizer(leftTap)
        
        let rightTap = UITapGestureRecognizer(target: self, action: #selector(nextStory))
        rightControl.addGestureRecognizer(rightTap)
    }
    
    @objc func nextStory() {
        progressBarContainer.next()
    }
    
    @objc func previousStory() {
        progressBarContainer.previous()
    }
    
}
