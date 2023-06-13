//
//  NewsViewModel.swift
//  Swift_Moya
//
//  Created by 이성호 on 2023/06/13.
//

import Combine
import Foundation

import CombineMoya
import Moya

final class NewsViewModel {
    
    // MARK: - property
    
    private let provider = MoyaProvider<NewsServices>()
    
    @Published var articles = [Article]() {
        didSet {
            print("articles 는 " , articles)
        }
    }
    
    let errorMessgae = PassthroughSubject<String, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - init
    
    init() {
        self.fetchNews()
    }
    
    func fetchNews() {
        self.provider.requestPublisher(.fetchArticle(country: "us"))
            .map(NewsResponse.self, using: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessgae.send(error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            } receiveValue: { response in
                print("response: ", response)
                self.articles = response.articles
            }
            .store(in: &self.cancellables)
    }
}
