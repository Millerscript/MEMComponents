//
//  ExampleStoriesScreenBarsViewController.swift
//  MEMComponentsTests
//
//  Created by Miller Mosquera on 26/05/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase
import MEMComponents
import Combine

class ExampleStoriesScreenBarsViewController: MEMBaseViewController {
    
    let progressBarContainer = MCBarsContainer()
    let navigationBar = MCStatusNavigation.newSet()
    let statusScreen = MCStatusScreen()
    var statusControls: MCStatusStoriesControls = MCStatusControls()
    public var cancellable = Set<AnyCancellable>()
    var nextTapped = false
    var previousTapped = false
    
    let images: [String] = [
        "https://i.pinimg.com/originals/ce/1a/4c/ce1a4c79b9b3026f292c7022b72b78e5.jpg",
        "https://i.pinimg.com/originals/61/b9/bd/61b9bdfd74d6c8ba29fb2dfc86521c31.jpg",
        "https://i.pinimg.com/originals/14/10/41/1410419f107c8f350bf6fa6fba674385.jpg",
        "https://i.pinimg.com/originals/d9/dd/10/d9dd10bf26d5746ff78b99ba61acd2ae.jpg",
        "https://i.pinimg.com/originals/b8/ac/0d/b8ac0d89b48ed5a4f6183187b766be97.jpg",
        "https://i.pinimg.com/originals/96/e1/e3/96e1e3589e993ef1747ebff7a4c37993.jpg",
        "https://i.pinimg.com/originals/7a/1c/1e/7a1c1e8ad44aa5a822d3668f8e60ce25.jpg"
    ]
    
    var imagesIndex: Int = 0
    
    deinit {
        print("ExampleStoriesScreenBarsViewController has been deinitialized")
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
                
        subscription()
        addHierarchy()
        setProgressBarsContainer()
        setNavigationBar()
        setControls()
        
        execDownload(index: imagesIndex)
    }
    
 
    private func setProgressBarsContainer() {
        progressBarContainer.attach(in: self.view, position: .TOP)
        progressBarContainer.setProgressBars(progressBars: [ProgressBarConfiguration(duration: 3, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .white),
                                                            ProgressBarConfiguration(duration: 3, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .white),
                                                            ProgressBarConfiguration(duration: 3, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .white),
                                                            ProgressBarConfiguration(duration: 3, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .white),
                                                            ProgressBarConfiguration(duration: 3, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .white),
                                                            ProgressBarConfiguration(duration: 3, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .white),
                                                            ProgressBarConfiguration(duration: 3, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .white)])
    }
    
    private func addHierarchy() {
        statusScreen.add(parent: self.view)
    }
    
    private func setNavigationBar() {
        self.view.addSubview(navigationBar)
        
        navigationBar.hook(.top, to: .bottom, of: progressBarContainer)
        navigationBar.hook(.left, to: .left, of: self.view, valueInset: 10)
        navigationBar.hook(.right, to: .right, of: self.view, valueInset: -10)
        navigationBar.setDimension(dimension: .height, value: 40)
        
        navigationBar.backAction = { [weak self] in
            guard let self else {return}
            print("Back")
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func setControls() {
        statusControls.attach(parentView: self.view)
        
        statusControls.leftAction = { [weak self] in
            guard let self else { return }
            previousTapped = true
            nextTapped = false
            imagesIndex-=1
            execDownload(index: imagesIndex)
        }
        statusControls.rightAction = { [weak self] in
            guard let self else { return }
            previousTapped = false
            nextTapped = true
            imagesIndex+=1
            execDownload(index: imagesIndex)
        }
    }
    
    private func execDownload(index: Int) {
        print("\n ****  Start Flow **** \n")
        statusScreen.downloadImage(imageUrl: images[index])
    }
    
    func subscription() {
        statusScreenSubject()
        statusBarsSubject()
    }
    
    private func statusScreenSubject() {
        statusScreen.subject.sink { error in
            print("An error has occured while downloading the image")
        } receiveValue: { [weak self] result in
            guard let self else { return }
            
            print("Prv: \(previousTapped), Nxt: \(nextTapped), index: \(imagesIndex)")
            
            if previousTapped {
                print("Prv Function")
                progressBarContainer.previous()
            } else if nextTapped {
                print("Nxt Function")
                progressBarContainer.next()
            } else {
                print("Str Function")
                progressBarContainer.start()
            }
        }.store(in: &statusScreen.cancellable)
    }
    
    private func statusBarsSubject() {
        progressBarContainer.subject.sink { [weak self] done in
            guard let self else { return }
            previousTapped = false
            nextTapped = false
            imagesIndex+=1
            execDownload(index: imagesIndex)
        }.store(in: &progressBarContainer.cancellable)
    }
}
