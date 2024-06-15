//
//  StatusStoriesModel.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 10/06/24.
//

import Foundation

public struct StatusStoriesModel: Codable {
    let barContainerPosition: String?
    let storiesData: [StoryData]?
    
    public init(barContainerPosition: String?, storiesData: [StoryData]?) {
        self.barContainerPosition = barContainerPosition
        self.storiesData = storiesData
    }
}

extension StatusStoriesModel {
    subscript(index: Int) -> StoryData {
        let storiesData = self.storiesData ?? []
        return storiesData[index]
    }
}

public struct StoryData: Codable {
    let duration: Double?
    let barBackground: String?
    let barProgressColor: String?
    let data: StatusData?
    
    public init(duration: Double?, barBackground: String?, barProgressColor: String?, data: StatusData?) {
        self.duration = duration
        self.barBackground = barBackground
        self.barProgressColor = barProgressColor
        self.data = data
    }
    
    public struct StatusData: Codable {
        let type: String?
        let imageUrl: String?
        let text: String?
        let textColor: String?
        let screenBackgroundColor: String?
        
        public init(type: String?, imageUrl: String?, text: String?, textColor: String?, screenBackgroundColor: String?) {
            self.type = type
            self.imageUrl = imageUrl
            self.text = text
            self.textColor = textColor
            self.screenBackgroundColor = screenBackgroundColor
        }
    }
}

public enum StatusBarsPosition: String {
    case TOP
    case BOTTOM
}

public enum StatusContentType: String {
    case IMAGE
    case TEXT
    case ERROR
}
