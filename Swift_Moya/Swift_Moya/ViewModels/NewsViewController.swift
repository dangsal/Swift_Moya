//
//  ViewController.swift
//  Swift_Moya
//
//  Created by 이성호 on 2023/06/13.
//

import UIKit

import SnapKit

final class NewsViewController: UIViewController {

    // MARK: - ui compoent
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - property
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
    }

    // MARK: - func
    
    private func setupLayout() {
        
    }

}

