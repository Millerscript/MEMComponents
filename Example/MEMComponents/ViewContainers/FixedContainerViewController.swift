//
//  FixedContainerViewController.swift
//  MEMComponentsExample
//
//  Created by Miller Mosquera on 17/06/24.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import MEMBase
import UIKit
import MEMComponents

class FixedContainerViewController: MEMBaseViewController {
    
    deinit {
        print("FixedContainerViewController has been deinitilialized")
    }
    
    required init(data: [String : Any]) {
        super.init(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
        useCases()
    }
    
    private func useCases() {
        everything()
        
        //onlyHeader()
        //onlyBody()
        //onlyFooter()
        
        //headerAndBody()
        //bodyAndFooter()
    }
    
    private func everything() {
        MCFixedContainerBuilder(direction: .VERTICAL, parent: self.view)
            .setHeader(view: OnboardingHeaderView(data: "", parent: self))
            .setBody(view: OnboardingBodyView())
            .setFooter(uiView: OnboardingFooterView())
            .build()
    }
    
    private func onlyHeader() {
        MCFixedContainerBuilder(direction: .VERTICAL, parent: self.view)
            .setHeader(view: OnboardingHeaderView(data: "", parent: self))
            .build()
    }
    
    private func onlyBody() {
        MCFixedContainerBuilder(direction: .VERTICAL, parent: self.view)
            .setBody(view: OnboardingBodyView())
            .build()
    }
    
    private func onlyFooter() {
        MCFixedContainerBuilder(direction: .VERTICAL, parent: self.view)
            .setFooter(uiView: OnboardingFooterView())
            .build()
    }
    
    
    private func headerAndBody() {
        MCFixedContainerBuilder(direction: .VERTICAL, parent: self.view)
            .setHeader(view: OnboardingHeaderView(data: "", parent: self))
            .setBody(view: OnboardingBodyView())
            .build()
    }
    
    private func bodyAndFooter() {
        MCFixedContainerBuilder(direction: .VERTICAL, parent: self.view)
            .setBody(view: OnboardingBodyView())
            .setFooter(uiView: OnboardingFooterView())
            .build()
    }
    
}
