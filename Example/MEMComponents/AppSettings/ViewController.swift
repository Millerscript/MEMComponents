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
import Combine

class ViewController: MEMBaseViewController {
    
    struct Constants {
        static let cellIdentifier = "DeeplinkCell"
        static let headerHeight = 40.0
        static let cellHeight = 50.0
    }
    
    let tableView: UITableView = .newSet()
    var model: [DeeplinkModel] = []
    
    var viewModel = ExamplesViewModel()
    var cancellable: [AnyCancellable] = []
    
    var mockExampleModel: MockExample?
    
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
 
        hideNavigationBar()
        self.hideNavigationBar()
        
        subscription()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavigationBar()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        Task(priority: .background) {
            await viewModel.readJSONFile(forName: "MockExample")
        }
    }
    
    func subscription() {
        viewModel.examples.sink { error in
            print(error)
        } receiveValue: { data in
            self.mockExampleModel = data
            self.tableView.reloadData()
        }.store(in: &cancellable)
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(DeeplinkCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        self.view.addSubview(tableView)
        
        tableView.hookSafeArea(.top, to: .top, of: self.view)
        tableView.hookSafeArea(.bottom, to: .bottom, of: self.view)
        tableView.hook(.left, to: .left, of: self.view, valueInset: 20)
        tableView.hook(.right, to: .right, of: self.view, valueInset: -20)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mockExampleModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.mockExampleModel?.sections[section].examples.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = self.mockExampleModel?.sections[indexPath.section].examples[indexPath.row] else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? DeeplinkCell else {return UITableViewCell()}
        
        cell.set(data: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderViewCell(frame: .zero)
        let title = self.mockExampleModel?.sections[section].title
        header.setTitle(text: title ?? "")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.headerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = self.mockExampleModel?.sections[indexPath.section].examples[indexPath.row] else { return }

        self.open(deeplink: data.deeplink)
    }
    
}
