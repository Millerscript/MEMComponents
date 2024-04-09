//
//  MCPageIndexControl.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 6/04/24.
//

import Foundation
import MEMBase

public class MCPageIndexControl: BasePageViewController {

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = .lightGray
        //self.dataSource = self
        //self.delegate = self
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
        if let pageDelegate = pageDelegate {
            pageDelegate.move(index: currentIndex)
        }
        self.moveControl(index: index, direction: direction)
    }


}
