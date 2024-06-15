//
//  ProgressBarConfiguration.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 18/05/24.
//

import Foundation

public struct ProgressBarConfiguration {
    let duration: Double
    let idleBackgroundColor: UIColor
    let progressColor: UIColor
    
    public init(duration: Double, idleBackgroundColor: UIColor, progressColor: UIColor) {
        self.duration = duration
        self.idleBackgroundColor = idleBackgroundColor
        self.progressColor = progressColor
    }
}
