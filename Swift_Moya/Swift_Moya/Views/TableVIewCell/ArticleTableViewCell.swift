//
//  ArticleTableViewCell.swift
//  Swift_Moya
//
//  Created by 이성호 on 2023/06/13.
//

import UIKit

import SnapKit

final class ArticleTableViewCell: UITableViewCell {
    
    // MARK: - ui component
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func setupLayout() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).inset(10)
            $0.leading.equalTo(self.snp.leading).inset(20)
            $0.trailing.equalTo(self.snp.trailing).inset(20)
        }
        
        self.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom).inset(10)
        }
    }
    
    func configureLabel(article: Article) {
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.desription
    }    
}
