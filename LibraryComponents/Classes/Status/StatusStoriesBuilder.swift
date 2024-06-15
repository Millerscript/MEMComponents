//
//  StatusStoriesBuilder.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 10/06/24.
//

import Foundation
import MEMBase

public class StatusStoriesBuilder {
    
    private var storiesView = MCStoriesView()
    
    public init() {}
    
    public func data(data: StatusStoriesModel) -> Self {
        storiesView.statusStoriesData = data
        return self
    }
    
    public func withNavigationBar(navigation: MCBarContainerNavigation) -> Self {
        storiesView.navigation = navigation
        return self
    }
    
    public func withStatusBarsControls(control: MCStatusStoriesControls) -> Self {
        storiesView.controls = control
        return self
    }
    
    public func build(parent: MEMBaseViewController) {
        storiesView.mainViewController = parent
        storiesView.attach()
    }
    
}
