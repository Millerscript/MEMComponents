//
//  MCPageViewController.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 30/03/24.
//

import Foundation
import UIKit
import MEMBase

public protocol MCPageDelegate: AnyObject {
    func move(index: Int)
}

public class MCPageViewController: UIPageViewController {
    
    public var pages: [MEMBaseViewController] = []
    private var currentIndex: Int = 0
    public var pageDelegate: MCPageDelegate?
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        self.view.backgroundColor = .lightGray
        //self.dataSource = self
        self.delegate = self
    }
      
    public func bind(to parent: UIView, topView: UIView? = nil) {
        self.view.hook(.left, to: .left, of: parent)
        self.view.hook(.right, to: .right, of: parent)
        
        if let topView = topView {
            self.view.hook(.top, to: .bottom, of: topView)
        } else {
            self.view.hook(.top, to: .top, of: parent)
        }
        
        self.view.hook(.bottom, to: .bottom, of: parent)
        
        self.moveControl(index: currentIndex, direction: .forward)
    }
    
    private func validateIndex(index: inout Int) {
        let minIndex = 0
        let maxIndex = pages.count - 1
        
        if index < minIndex {
            index = minIndex
            return
        }
        
        if index > maxIndex {
            index = maxIndex
            return
        }
    }
    
    public func moveTo(direction: UIPageViewController.NavigationDirection) {
        switch direction {
        case .forward:
            currentIndex += 1
        case .reverse:
            currentIndex -= 1
        @unknown default:
            fatalError()
        }
        
        validateIndex(index: &currentIndex)
        if let pageDelegate = pageDelegate {
            pageDelegate.move(index: currentIndex)
        }
        
        self.moveControl(index: currentIndex, direction: direction)
    }
    
    public func moveTo(index: Int) {
        var direction: NavigationDirection = .forward
        if index < currentIndex {
            direction = .reverse
        } else if index > currentIndex {
            direction = .forward
        } else if index == currentIndex {
            return
        }
        
        currentIndex = index
        
        self.moveControl(index: index, direction: direction)
    }
    
    public func moveControl(index: Int, direction: UIPageViewController.NavigationDirection) {
        self.setViewControllers([pages[index]], direction: direction, animated: true, completion: nil)
        self.didMove(toParent: self)
    }
}

/*
extension MCPageViewController: UIPageViewControllerDataSource {
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = getNextIndex(using: viewController) else { return nil }
        lastIndex = index
        guard let customViewController = setNewViewController(with: index) else { return nil }
        
        return customViewController
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
        guard let index = getPreviousIndex(using: viewController) else { return nil }
        lastIndex = index
        guard let customVc = setNewViewController(with: index) else { return nil }
                 
        return customVc
    }
    
    // IDK
    private func getNextIndex(using viewController: UIViewController) -> Int? {
        guard let currentVC = viewController as? BaseItemPageViewController else { return nil }

        var index = currentVC.index
                
        if index >= self.customViewControllers.count - 1 {
           return nil
        }

        index += 1

        return index
    }

    private func getPreviousIndex(using viewController: UIViewController) -> Int? {
        guard let currentViewController = viewController as? BaseItemPageViewController else { return nil }

        var index = currentViewController.index

        if index == 0 { return nil }

        index -= 1

        return index
    }

    private func setNewViewController(with index: Int) -> UIViewController? {
        guard let viewController = viewController else { return UIViewController() }
        viewController.index = index
        return viewController
    }
}*/

extension MCPageViewController: UIPageViewControllerDelegate {
    
    // With this block show up the PageControl ( dots )
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {

        guard let firstViewController = pages.first else {
            return 0
        }
        
        guard let firstViewControllerIndex = pages.firstIndex(of: firstViewController) else {
            return 0
        }

        return 0
    }
}
