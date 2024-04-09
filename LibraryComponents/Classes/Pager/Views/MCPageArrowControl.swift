//
//  MCPageArrowControl.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 6/04/24.
//

import Foundation
import MEMBase

public class MCPageArrowControl: BasePageViewController {

    private var buttonsRegion: UIView = .init().newSet()

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = .lightGray
        setButtonsRegion()
    }
    
    
    func moveTo(direction: direction) {
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
    
    private func setButtonsRegion() {
        self.view.addSubview(buttonsRegion)
        buttonsRegion.hookAxis(.vertical, sameOf: self.view)
        buttonsRegion.hook(.left, to: .left, of: self.view)
        buttonsRegion.hook(.right, to: .right, of: self.view)
        buttonsRegion.setDimension(dimension: .height, value: 60)
        
        buttonsRegion.backgroundColor = .red
    }
    
}
