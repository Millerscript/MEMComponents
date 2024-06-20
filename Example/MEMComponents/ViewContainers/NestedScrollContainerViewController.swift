//
//  NestedScrollContainerViewController.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 17/06/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase
import UIKit
import MEMComponents

class NestedScrollContainerViewController: MEMBaseViewController {
    
    private var scrollContainer = MCNestedScrollContainer(direction: .VERTICAL)
 
    deinit {
        print("NestedScrollContainerViewController has been deinitialized")
    }
    
    required init(data: [String : Any]) {
        super.init(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showNavigationBar()
        setupViews()
    }
    
    private func setupViews() {
        setScrollContainer()
    }

    private func setScrollContainer() {
        scrollContainer.bind(into: self.view)
        scrollContainer.add(view: OnboardingHeaderView())
        scrollContainer.add(view: OnboardingBodyView())
        scrollContainer.add(view: OnboardingFooterView())
        scrollContainer.add(view: SampleImageSectionView())
    }
    
}
