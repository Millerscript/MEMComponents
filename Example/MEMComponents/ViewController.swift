//
//  ViewController.swift
//  MEMComponents
//
//  Created by Millerscript on 03/26/2024.
//  Copyright (c) 2024 Millerscript. All rights reserved.
//

import UIKit
import MEMBase
import MEMComponents

class ViewController: MEMBaseViewController {
    
    struct Constants {
        static let cellIdentifier = "DeeplinkCell"
        static let headerHeight = 100.0
        static let cellHeight = 50.0
    }
    
    let tableView = UITableView(frame: .zero)
    var model: [DeeplinkModel] = []
    
    required init(data: [String : Any]) {
        super.init(data: data)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setTableView()
        setModel()

        hideNavigationBar()
        self.hideNavigationBar()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavigationBar()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTableView() {
       tableView.delegate = self
       tableView.dataSource = self
       tableView.separatorStyle = .none
       tableView.register(DeeplinkCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
       tableView.translatesAutoresizingMaskIntoConstraints = false
       
       self.view.addSubview(tableView)
       
       NSLayoutConstraint.activate([
           tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
           tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
           tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
           tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
       ])
    }

    func setModel() {
       model.append(DeeplinkModel(title: "TabView Example", deeplink: "memcomponents://example/tabView"))
       model.append(DeeplinkModel(title: "Pager(index) Example", deeplink: "memcomponents://example/pager/index"))
       model.append(DeeplinkModel(title: "Pager(buttons) Example", deeplink: "memcomponents://example/pager/buttons"))
       model.append(DeeplinkModel(title: "Pager(gesture) Example", deeplink: "memcomponents://example/pager/gesture"))
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = model[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? DeeplinkCell else {return UITableViewCell()}
        
        cell.set(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderViewCell(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.headerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deeplink = model[indexPath.row]
        self.open(deeplink: deeplink.deeplink)
    }
    
}

