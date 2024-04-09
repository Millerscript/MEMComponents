//
//  TabProtocol.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 27/03/24.
//

import Foundation
import UIKit
import Combine

public protocol TabProtocol: UIView, AnyObject {
    init(configuration: MCTabViewConfiguration)
    var configuration: MCTabViewConfiguration { get set }
    var index: Int { get set }
    var selected: Bool { get set }
    var action: PassthroughSubject<TabData, Never> { get set }
    func set(data: MCTabItemModel)
    func create() -> Self
}

public struct TabData {
    let index: Int
    let type: TabStyle
}

public enum TabStyle {
    case TEXT
    case IMAGE
    case COMPOUSE
}
