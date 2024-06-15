//
//  MCProgressBar.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 12/04/24.
//

import Foundation
import MEMBase
import UIKit
import Combine

protocol MCProgressBarDelegate {
    func nextBarWith(id: Int)
}

public protocol MCProgressBarView_: AnyObject {
    var LOWER_DURATION_ALLOWED: Double {get set}
    var duration: Double {get set}
    var animationWillStart: ( () -> Void )? { get set }
    var animationDidFinish: ( () -> Void )? { get set }
    
    func setCornerRadius(radius: CGFloat) -> Self
    func setBackground(background: UIColor) -> Self
    func setAnimationBackgroundColor(background: UIColor) -> Self
    func setDuration(duration: Double) -> Self
    func build() -> UIView
    
    func start()
    func resume()
    func pause()
    func stop(fill: Bool)
}


open class MCProgressBarBuilder {
    
    struct Constants {
        static let barCornerRadius: CGFloat = 4
    }
    
    private var animateBar: UIView = UIView.newSet()
    private var wrapperBar: MCProgressBarView = MCAnimationProgressBar()
    
    public var LOWER_DURATION_ALLOWED: Double = 0.5
    public var duration: Double = 0.5
    
    public var animationWillStart: (() -> Void)?
    public var animationDidFinish: (() -> Void)?

    public func setBackground(background: UIColor) -> Self {
        self.wrapperBar.backgroundColor = background
        return self
    }
    
    public func setAnimationBackgroundColor(background: UIColor) -> Self {
        self.animateBar.backgroundColor = background
        return self
    }
    
    public func setDuration(duration: Double) -> Self {
        self.duration = duration
        return self
    }
    
    public func build() -> MCProgressBarView {
        self.wrapperBar.layer.cornerRadius = Constants.barCornerRadius
        self.animateBar.layer.cornerRadius = Constants.barCornerRadius
        self.wrapperBar.alpha = 0.9
        self.wrapperBar.prepareForHooks()
        self.wrapperBar.addSubview(animateBar)
        self.wrapperBar.duration = self.duration
        return self.wrapperBar
    }

}

