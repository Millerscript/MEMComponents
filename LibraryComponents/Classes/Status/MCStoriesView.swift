//
//  MCStoriesView.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 3/06/24.
//

import Foundation
import MEMBase
import Combine
import UIKit

internal class MCStoriesView: UIView {
    
    public var statusStoriesData: StatusStoriesModel? {
        didSet {
            setProgressBarsContainer()
            setBarsSubscription()
        }
    }
    
    public var barsContainer: MCBarsContainerProtocol?
    public var navigation: MCBarContainerNavigation?
    public var controls: MCStatusStoriesControls?
    public weak var mainViewController: MEMBaseViewController?
    
    private var cancellable = Set<AnyCancellable>()
    private var nextTapped = false
    private var previousTapped = false
    private var itemIndex: Int = 0
    private var strategy: MCStatusStrategy?
    
    deinit {
        print("MCStoriesView has been deinilitialized")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareForHooks()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attach() {
        guard let mainViewController else { return }
        mainViewController.view.addSubview(self)
        self.hookingToParentView()
        self.backgroundColor = .black
        setNavigationBar()
        setControls()
        
        executeDownload(index: 0)
    }
    
    
    private func setProgressBarsContainer() {
        barsContainer = MCBarsContainer()
        barsContainer?.attach(in: self, position: MCStoriesDataAdapter.getBarsPosition(position: self.statusStoriesData?.barContainerPosition ?? "TOP"))
        barsContainer?.setProgressBars(progressBars: MCStoriesDataAdapter.getProgressBarsConfiguration(data: self.statusStoriesData?.storiesData ?? []))
    }
    
    private func setBarsSubscription() {
        barsContainer?.subject.sink { [weak self] finished in
            guard let self else { return }
            previousTapped = false
            nextTapped = false
            itemIndex+=1
            executeDownload(index: itemIndex)
        }.store(in: &cancellable)
    }
    
    // MARK: - Navigation bar
    private func setNavigationBar() {
        if let navigation = self.navigation, let barsContainer = self.barsContainer {
            navigationConstraints(navigation: navigation, barsContainer: barsContainer, barsPosition: MCStoriesDataAdapter.getBarsPosition(position: self.statusStoriesData?.barContainerPosition ?? "TOP"))
            navigationBackAction(navigation: navigation)
        }
    }
    
    private func navigationConstraints(navigation: MCBarContainerNavigation, barsContainer: MCBarsContainerProtocol, barsPosition: StatusBarsPosition) {
        self.addSubview(navigation)
        if barsPosition == .TOP {
            navigation.hook(.top, to: .bottom, of: barsContainer)
        } else if barsPosition == .BOTTOM {
            navigation.hookSafeArea(.top, to: .top, of: self)
        }
        
        navigation.hook(.left, to: .left, of: self, valueInset: 10)
        navigation.hook(.right, to: .right, of: self, valueInset: -10)
        navigation.setDimension(dimension: .height, value: 40)
    }
    
    private func navigationBackAction(navigation: MCBarContainerNavigation) {
        navigation.backAction = { [weak self] in
            guard let self else {return}
            guard let parentViewController = mainViewController else {return}
            parentViewController.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Controls
    private func setControls() {
        if var statusControls = self.controls {
            statusControls.attach(parentView: self)
            
            leftActionFlow(statusControls: &statusControls)
            rightActionFlow(statusControls: &statusControls)
        }
    }
    
    private func leftActionFlow(statusControls: inout MCStatusStoriesControls) {
        statusControls.leftAction = { [weak self] in
            guard let self else { return }
            previousTapped = true
            nextTapped = false
            itemIndex-=1
            executeDownload(index: itemIndex)
        }
    }
    
    private func rightActionFlow(statusControls: inout MCStatusStoriesControls) {
        statusControls.rightAction = { [weak self] in
            guard let self else { return }
            previousTapped = false
            nextTapped = true
            itemIndex+=1
            executeDownload(index: itemIndex)
        }
    }
    
    // MARK: - Main Interface ( Image, Text and Video )
    private func bringSubviewsToFront() {
        self.bringSubviewToFront(barsContainer!)
        self.bringSubviewToFront(navigation!)
        self.bringSubviewToFront((controls?.getView())!)
    }
    
    private func removeStrategyFromSuperView() {
        if let childView = self.viewWithTag(200000) {
            childView.removeFromSuperview()
        }
    }
    
    private func executeDownload(index: Int) {
        defer {
            bringSubviewsToFront()
        }
        
        removeStrategyFromSuperView()
        
        let type = MCStoriesDataAdapter.getStatusType(type: self.statusStoriesData?[index].data?.type ?? "ERROR")
        strategy = getStrategyInstance(type: type)
        
        statusScreenSubject(strategy: strategy!)
        strategy?.attach(parent: self)
        
        downloadStrategyData(type: type, strategy: strategy!, index: index)
    }
    
    private func getStrategyInstance(type: StatusContentType) -> MCStatusStrategy {
        switch type {
        case .IMAGE:
            strategy = MCStatusImageStrategy()
        case .TEXT:
            strategy = MCStatusTextStrategy()
        case .ERROR:
            strategy = MCStatusErrorStrategy()
        }
        
        return strategy!
    }
    
    private func downloadStrategyData(type: StatusContentType, strategy: MCStatusStrategy, index: Int) {
        switch type {
        case .IMAGE:
            strategy.download(data: URL(string: self.statusStoriesData?[index].data?.imageUrl ?? "")!)
        case .TEXT:
            strategy.download(data: self.statusStoriesData?[index].data?.text)
        case .ERROR:
            strategy.download(data: "An error has occurred")
        }
    }
 
    private func statusScreenSubject(strategy: MCStatusStrategy) {
        strategy.subject.sink { error in
            print("An error has occured while downloading the image")
        } receiveValue: { [weak self]  result in
            guard let self else { return }
            if previousTapped {
                barsContainer?.previous()
            } else if nextTapped {
                barsContainer?.next()
            } else {
                barsContainer?.start()
            }
        }.store(in: &cancellable)
    }

}
