//
//  MCStatusStretegy.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 11/06/24.
//

import Foundation
import UIKit
import Combine
import Kingfisher

internal protocol MCStatusStrategy: AnyObject {
    var subject: PassthroughSubject<Void, NSError> {get set}
    func attach(parent: UIView)
    func download<T>(data: T)
}
