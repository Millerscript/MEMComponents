//
//  MCStoriesDataAdapter.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 11/06/24.
//

import Foundation

internal struct MCStoriesDataAdapter {
    
    static func getBarsPosition(position: String) -> StatusBarsPosition {
        if position.uppercased() == "TOP" {
            return .TOP
        } else if position.uppercased() == "BOTTOM" {
            return .BOTTOM
        }
        
        return .TOP
    }
    
    static func getStatusType(type: String) -> StatusContentType {
        if type.uppercased() == "IMAGE" {
            return .IMAGE
        } else if type.uppercased() == "TEXT" {
            return .TEXT
        }
        
        return .ERROR
    }
    
    static func getProgressBarsConfiguration(data: [StoryData]) -> [ProgressBarConfiguration] {
        var configuration: [ProgressBarConfiguration] = []
        data.forEach { storyData in
            configuration.append(ProgressBarConfiguration(duration: storyData.duration ?? 0, idleBackgroundColor: .lightGray.withAlphaComponent(0.4), progressColor: .white))
        }
        
        return configuration
    }
}
