//
//  ExampleAppRouteHandler.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 27/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase

class ExampleAppRouteHandler: MEMBaseRouteHandlerProtocol {
    
    var manager: MEMBaseDeeplinkManager = MEMBaseDeeplinkManager.shared
    
    func add() {
        manager.register(endPoint: "tabView", viewController: TabViewExampleViewController.self)
        manager.register(endPoint: "index", viewController: PagerIndexViewController.self)
        manager.register(endPoint: "buttons", viewController: PagerButtonsViewController.self)
        manager.register(endPoint: "gesture", viewController: PagerIndexViewController.self)
    }
}
