//
//  DeeplinkModel.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 28/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
struct DeeplinkModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let deeplink: String
}
