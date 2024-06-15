//
//  AnimationHelper.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 30/04/24.
//

import Foundation
import UIKit
import Combine

public class BarAnimationHelper {
    
    public static var animationStatusSubject = PassthroughSubject<Bool, Never>()
    
    struct Constants {
        static let DEFAULT_DURATION: Double = 1
        static let DEFAULT_DELAY: Double = 0.2
    }
    
    public static func pauseAnimation(layer: CALayer) {
        let pauseAnimation: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pauseAnimation
    }
    
    public static func resumeAnimation(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    private static func setDimentions(view: UIView, height: CGFloat, width: CGFloat) {
        view.frame.size.width = width
        view.frame.size.height = height
    }
    
    public static func setAnimation(view: UIView, duration: Double?, height: CGFloat, width: CGFloat) {
        view.frame.size.height = height
        UIView.animate(withDuration: duration ?? Constants.DEFAULT_DURATION, delay: Constants.DEFAULT_DELAY) {
            view.frame.size.width = width
        } completion: { finished in
            if finished {
                self.animationStatusSubject.send(true)
            }
        }
    }
    
    public static func setAnimation(view: UIView, duration: Double?, height: CGFloat, width: CGFloat, completion: @escaping(() -> Void)) {
        view.frame.size.height = height
        UIView.animate(withDuration: duration ?? Constants.DEFAULT_DURATION, delay: Constants.DEFAULT_DELAY) {
            view.frame.size.width = width
        } completion: { finished in
            if finished {
                completion()
            }
        }
    }
    
    public static func setAnimationInZero(view: UIView, height: CGFloat) {
        setDimentions(view: view, height: height, width: 0.0)
    }
    
    public static func fillWithoutAnimation(view: UIView, height: CGFloat, width: CGFloat) {
        setDimentions(view: view, height: height, width: width)
    }

}
