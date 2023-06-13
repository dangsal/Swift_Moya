//
//  ViewController.swift
//  Swift_Moya
//
//  Created by 이성호 on 2023/06/13.
//

import Combine
import UIKit

import SnapKit

final class NewsViewController: UIViewController {

    // MARK: - ui compoent
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // MARK: - property
    
    private let newsViewModel: NewsViewModel = NewsViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupLayout()
        self.setupDelegation()
        self.setBinding()
    }

    // MARK: - func
    
    private func setupNavigationBar() {
        self.navigationItem.title = "News"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupLayout() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.top)
            $0.leading.equalTo(self.view.snp.leading)
            $0.trailing.equalTo(self.view.snp.trailing)
            $0.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
    private func setupDelegation() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setBinding() {
        self.newsViewModel.$articles
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &self.cancellables)
        
        self.newsViewModel.errorMessgae
            .receive(on: DispatchQueue.main)
            .sink { message in
                print(message)
            }
            .store(in: &self.cancellables)
    }

}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsViewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArticleTableViewCell
        
        let article = self.newsViewModel.articles[indexPath.row]
        cell.configureLabel(article: article)
        return cell
    }
}

extension NewsViewController: UITableViewDelegate { }
