//
//  MCStatusErrorStrategy.swift
//  MEMComponents
//
//  Created by Miller Mosquera on 13/06/24.
//

import Foundation
import UIKit
import Combine
import MEMBase

class MCStatusErrorStrategy: MCStatusStrategy {
    private var container: UIView = .newSet()
    var subject: PassthroughSubject<Void, NSError> = PassthroughSubject()
    
    lazy var titleLbl: UILabel = {
        let label = UILabel.newSet()
        label.text = ""
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    public init() {
        addHierarchy()
        setConstraints()
    }
    
    func attach(parent: UIView) {
        container.tag = 200000
        container.backgroundColor = .black.withAlphaComponent(0.6)
        parent.addSubview(container)
        container.hookingToParentView()
    }
    
    func download<T>(data: T) {
        guard let data = data.self as? String else { return }
        
        titleLbl.text = data
        subject.send()
    }
    
    private func addHierarchy() {
        self.container.addSubview(titleLbl)
    }
    
    private func setConstraints() {
        titleLbl.hookAxis(.vertical, sameOf: container)
        titleLbl.hook(.left, to: .left, of: container)
        titleLbl.hook(.right, to: .right, of: container)
    }
}
