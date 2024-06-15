//
//  MCBarsContainer.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 15/04/24.
//

import Foundation
import UIKit
import MEMBase
import Combine

public protocol MCBarsContainerProtocol: UIView {
    var subject: PassthroughSubject<Bool, Never> {get set}
    func setProgressBars(progressBars: [ProgressBarConfiguration])
    func attach(in parentView: UIView, position: StatusBarsPosition)
    func attach(in parentView: UIView, position: StatusBarsPosition, navigationBar: MCBarContainerNavigation?)
    func start()
    func previous()
    func next()
}

// TODO: Change the access level to internal
public class MCBarsContainer: UIView {

    struct Constants {
        static let progressBarsSpacing = 6.0
    }
    
    private var progressBars: [ProgressBarConfiguration] = [] {
        didSet {
            addHierarchy()
            setConstraints()
            renderProgressBars()
        }
    }
    
    public var subject: PassthroughSubject<Bool, Never> = PassthroughSubject()
    public var cancellable = Set<AnyCancellable>()
    
    private lazy var progressBarsContainer: UIStackView = {
        let stack = UIStackView.newSet()
        stack.distribution = .fillEqually
        stack.spacing = Constants.progressBarsSpacing
        stack.backgroundColor = .clear
        return stack
    }()

    var cIndex: Int = 0
    
    deinit {
        print("Wrapper has been deinitialized")
    }
    
    private func addHierarchy() {
        self.isUserInteractionEnabled = true
        self.addSubview(progressBarsContainer)
    }
    
    private func setConstraints() {
        progressBarsContainer.hook(.left, to: .left, of: self)
        progressBarsContainer.hook(.right, to: .right, of: self)
        progressBarsContainer.setDimension(dimension: .height, value: 6)
        progressBarsContainer.hookAxis(.horizontal, sameOf: self)
    }
    
    private func renderProgressBars() {
        
        printBarConfiguration()
        
        progressBars.forEach { configuration in
            let bar = createBar(configuration: configuration)
            elementSusbcription(element: bar)
            progressBarsContainer.addArrangedSubview(bar)
            progressBarsContainer.layoutIfNeeded()
        }
    }
    
    private func printBarConfiguration() {
        #if DEBUG
        for (index, configuration) in progressBars.enumerated() {
            print("index: \(index), config: \(configuration.duration)")
        }
        #endif
    }
    
    private func createBar(configuration: ProgressBarConfiguration) -> MCProgressBarView {
        return MCProgressBarBuilder()
            .setDuration(duration: configuration.duration)
            .setBackground(background: configuration.idleBackgroundColor)
            .setAnimationBackgroundColor(background: configuration.progressColor)
            .build()
    }
    
    @discardableResult
    private func getElementFromContainer(index: Int) -> MCProgressBarView {
        return self.progressBarsContainer[index] ?? MCAnimationProgressBar()
    }
    
    /**
     * Validate the max bound of the elements
     * - returns: false if the cIndex is bigger than the numberOfBars
     * - returns: true if the cIndex hasn't reached the bounds
     */
    private func validateMaxBound() -> Bool {
        let numberOfBars = progressBarsContainer.arrangedSubviews.count - 1
        
        if cIndex > numberOfBars {
            cIndex = numberOfBars

            return false
        }

        return true
    }
    
    
    /**
     * Validate the first index bound
     * Stop the flow if the cIndex is less than zero
     */
    private func validateMinBound() {
        if cIndex < 0 {
            return
        }
    }
    
    /**
     * MCProgressBarView observable subscription to listen the events from bus
     * - parameters element: MCProgressBarView previously added in the builder
     *  Get this from wrapper
     */
    private func elementSusbcription(element: MCProgressBarView) {
        element.animationFinished.sink { [weak self] _ in
            guard let self = self else { return }
                cIndex += 1 // Always go forward
                if self.validateMaxBound() {
                    //forward()
                    subject.send(true)
                }
        }.store(in: &cancellable)
    }
    
    /**
     * This function always start the animation for the next element
     */
    private func forward() {
        let element = getElementFromContainer(index: cIndex)
        element.start()
    }
    
}

extension MCBarsContainer {
    
    /**
     * Set the progress bars container to the top of the screen
     * - parameters parentView: View where the progress bars container is going to be attached
     */
    private func setToTop(parentView: UIView) {
        setDefaultAnchors(parentView: parentView)
        self.hookParentView(toSafeArea: .top)
    }
    
    /**
     * Set the progress bars container to the bottom of the screen
     * - parameters parentView: View where the progress bars container is going to be attached
     */
    private func setToBottom(parentView: UIView) {
        setDefaultAnchors(parentView: parentView)
        self.hookParentView(toSafeArea: .bottom, valueInset: -20)
    }
    
    /**
     * Set the default anchors to the parent view
     * - parameters parentView: View where its going to set the constraints
     */
    private func setDefaultAnchors(parentView: UIView) {
        self.hook(.left, to: .left, of: parentView, valueInset: 10)
        self.hook(.right, to: .right, of: parentView, valueInset: -10)
        self.setDimension(dimension: .height, value: 20)
    }
}

extension MCBarsContainer: MCBarsContainerProtocol {
  
    
    public func setProgressBars(progressBars: [ProgressBarConfiguration]) {
        self.progressBars = progressBars
    }
    
    private func configuration(parentView: UIView, position: StatusBarsPosition) {
        parentView.addSubview(self)
        self.prepareForHooks()
        switch position {
        case .TOP:
            setToTop(parentView: parentView)
        case .BOTTOM:
            setToBottom(parentView: parentView)
        }
    }
    
    private func setNavigationBar(navigationBar: MCBarContainerNavigation?, parentView: UIView, position: StatusBarsPosition) {
        if let navigationBar {
            if position == .TOP {
                self.addSubview(navigationBar)
                navigationBar.hook(.top, to: .bottom, of: self)
                navigationBar.hook(.left, to: .left, of: self)
                navigationBar.hook(.right, to: .right, of: self)
                navigationBar.setDimension(dimension: .height, value: 40)
            } else if position == .BOTTOM {
                parentView.addSubview(navigationBar)
                navigationBar.hook(.top, to: .top, of: parentView)
                navigationBar.hook(.left, to: .left, of: parentView)
                navigationBar.hook(.right, to: .right, of: parentView)
                navigationBar.setDimension(dimension: .height, value: 40)
            }

        }
    }
    
    public func attach(in parentView: UIView,
                       position: StatusBarsPosition,
                       navigationBar: MCBarContainerNavigation?)
    {
        configuration(parentView: parentView, position: position)
        setNavigationBar(navigationBar: navigationBar, parentView: parentView, position: position)
    }
    
    public func attach(in parentView: UIView,
                       position: StatusBarsPosition)
    {
        configuration(parentView: parentView, position: position)
    }
    
    /**
     * Start the animation's progress bar
     */
    public func start() {
        getElementFromContainer(index: cIndex).start()
    }
    
    /**
     * Move to the next animation progress bar
     */
    public func next() {
        getElementFromContainer(index: cIndex).fill()
        cIndex += 1
        getElementFromContainer(index: cIndex).start()
    }
    
    /**
     * Move to the previous animation progress bar
     */
    public func previous() {
        validateMinBound()
        
        getElementFromContainer(index: cIndex).stop()
        cIndex -= 1
        getElementFromContainer(index: cIndex).start()
    }
}

extension UIStackView {
    subscript (_ index: Int) -> MCProgressBarView? {
        guard let item = self.arrangedSubviews[index] as? MCProgressBarView else { return nil }
        return item
    }
}
