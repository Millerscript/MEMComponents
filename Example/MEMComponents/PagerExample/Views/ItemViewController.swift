//
//  ItemViewController.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 30/03/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MEMBase
import MEMComponents

class ItemViewController: MEMBaseViewController {
    
    var lblTitle: UILabel = {
        let label = UILabel().newSet()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Item pager"
        return label
    }()
    
    var titleText: String = ""
    
    required init(data: [String : Any]) {
        super.init(data: data)
        print( (data["index"] as? Int)! )
        print("It has been loaded")
        print( (data["data"] as? String)! )
        
        titleText = (data["data"] as? String)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red.withAlphaComponent(0.4)
        setTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Loaded")
    }
    
    private func setTitle() {
        self.view.addSubview(lblTitle)
        lblTitle.hook(.top, to: .top, of: self.view, valueInset: 30)
        lblTitle.hook(.left, to: .left, of: self.view)
        lblTitle.hook(.right, to: .right, of: self.view)
        lblTitle.text = titleText
    }
}
