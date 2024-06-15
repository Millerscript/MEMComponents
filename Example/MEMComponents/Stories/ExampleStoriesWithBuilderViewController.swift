//
//  ExampleStoriesWithBuilderViewController.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 13/06/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase
import MEMComponents
import Combine

class ExampleStoriesWithBuilderViewController: MEMBaseViewController {
    
    let navigationBar = MCStatusNavigation.newSet()
    var statusControls: MCStatusStoriesControls = MCStatusControls()

    deinit {
        print("ExampleStoriesWithBuilderViewController has been deinitialized")
    }
    
    required init(data: [String : Any]) {
        super.init(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setStatusStoriesData()
    }
    
    private func setStatusStoriesData() {
        let storyData1 = StoryData(duration: 2, barBackground: "", barProgressColor: "", data: StoryData.StatusData(type: "IMAGE", imageUrl: "https://i.pinimg.com/originals/ce/1a/4c/ce1a4c79b9b3026f292c7022b72b78e5.jpg", text: nil, textColor: nil, screenBackgroundColor: nil))
        let storyData2 = StoryData(duration: 1, barBackground: "", barProgressColor: "", data: StoryData.StatusData(type: "IMAGE", imageUrl: "https://i.pinimg.com/originals/61/b9/bd/61b9bdfd74d6c8ba29fb2dfc86521c31.jpg", text: nil, textColor: nil, screenBackgroundColor: nil))
        let storyData3 = StoryData(duration: 3, barBackground: "", barProgressColor: "", data: StoryData.StatusData(type: "TEXT", imageUrl: "", text: "Despite the difficulties, i'm going to work in my skills on my own! Take on count", textColor: nil, screenBackgroundColor: nil))
        
        let storiesData = StatusStoriesModel(barContainerPosition: "TOP", storiesData: [storyData1, storyData2, storyData3])
        
        StatusStoriesBuilder()
            .data(data: storiesData)
            .withNavigationBar(navigation: navigationBar)
            .withStatusBarsControls(control: statusControls)
            .build(parent: self)
    }

}
