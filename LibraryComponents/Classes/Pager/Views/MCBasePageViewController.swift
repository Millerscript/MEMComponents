//
//  MCBasePageViewController.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 7/04/24.
//

import Foundation
import MEMBase

public class BasePageViewController: UIPageViewController {
    public var pages: [MEMBaseViewController] = []
    public var currentIndex: Int = 0
    public weak var pageDelegate: MCPageDelegate?
    typealias direction = UIPageViewController.NavigationDirection
    
    private var minIndex = 0
    private var maxIndex: Int {
        return pages.count - 1
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func validateIndex(index: inout Int) {

        if index < minIndex {
            index = minIndex
            return
        }
        
        if index > maxIndex {
            index = maxIndex
            return
        }
    }
    
    public func validateIndex(index: Int) -> Bool {

        if index < minIndex || index > maxIndex { return false }
        
        return true
    }
    
    public func moveControl(index: Int, direction: UIPageViewController.NavigationDirection) {
        if validateIndex(index: index) {
            self.setViewControllers([pages[index]], direction: direction, animated: true, completion: nil)
            self.didMove(toParent: self)
        }
    }
    
    public func moveControl(viewController: MEMBaseViewController, direction: UIPageViewController.NavigationDirection) {
        self.setViewControllers([viewController], direction: direction, animated: true, completion: nil)
        self.didMove(toParent: self)
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
}
