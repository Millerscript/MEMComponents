//
//  MCAnimationProgressBar.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 30/04/24.
//

import Foundation
import UIKit
import Combine

public protocol MCProgressBarView: UIView {
    var animationFinished: PassthroughSubject<Void, Never> {get set}
    var duration: Double {get set}
    func start()
    func resume()
    func pause()
    func stop()
    func fill()
}

public class MCAnimationProgressBar: UIView, MCProgressBarView {
    
    public var duration: Double = 0.5
    public var animationFinished: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    public var cancellable = Set<AnyCancellable>()
    
    // MARK: - Computed propperty
    private var animateBar: UIView {
        return self.subviews.first ?? UIView()
    }
    
    init() {
        super.init(frame: .zero)
        
        // MARK: - This was a bug, i need to know why, At the end i've gotten rid of it
        //subscription()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func start() {
        Task { @MainActor in
            animateBar.frame.size.width = 0.0
            
            // MARK: - This was a bug, i need to know why, At the end i've gotten rid of it
            //BarAnimationHelper.setAnimation(view: animateBar, duration: duration, height: self.layer.frame.height, width: self.layer.frame.width)
            
            // MARK: - This works well
            BarAnimationHelper.setAnimation(view: animateBar, duration: duration, height: self.layer.frame.height, width: self.layer.frame.width) {
                self.animationFinished.send()
            }
        }
    }
    
    // MARK: - Subscription, I didn't use it anymore, it was causing a bug
    public func subscription() {
        BarAnimationHelper.animationStatusSubject.sink { [weak self] finished in
            guard let self = self else { return }
            self.animationFinished.send()
        }.store(in: &cancellable)
    }
    
    public func resume() {
        BarAnimationHelper.resumeAnimation(layer: animateBar.layer)
    }
    
    public func pause() {
        BarAnimationHelper.pauseAnimation(layer: animateBar.layer)
    }
    
    public func stop() {
        Task { @MainActor in
            BarAnimationHelper.setAnimationInZero(view: animateBar, height: self.layer.frame.height)
            removeAnimationsFromLayers()
            self.layoutIfNeeded()
            self.setNeedsLayout()
        }
    }
    
    public func fill() {
        Task { @MainActor in
            BarAnimationHelper.fillWithoutAnimation(view: animateBar, height: self.layer.frame.height, width: self.layer.frame.width)
            removeAnimationsFromLayers()
            self.layoutIfNeeded()
            self.setNeedsLayout()
        }
    }
    
    private func removeAnimationsFromLayers() {
        animateBar.layer.removeAllAnimations()
        self.layer.removeAllAnimations()
    }
}

