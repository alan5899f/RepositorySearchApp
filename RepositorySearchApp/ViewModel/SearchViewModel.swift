//
//  SearchViewModel.swift
//  RepositorySearchApp
//
//  Created by 陳韋綸 on 2023/10/20.
//

import UIKit

class SearchViewModel {

    public var repositoryResponse: (RepositoryResponse) -> () = { response in }
    public var errorResponse: (Error) -> () = { error in }

    func searchRepositoryApiBinding(q: String) {

        let queryItems: [ApiBodyItem] = [
            ApiBodyItem(key: "q", value: "\(q)"), // 預設： tetris+language:assembly
            ApiBodyItem(key: "sort", value: "stars"),
            ApiBodyItem(key: "order", value: "desc"),
        ]

        ApiServersModel(api: .searchRepository, queryItems: queryItems).requestHttpServer { [weak self] (result: Result<RepositoryResponse, Error>) in
            switch result {
            case .success(let success):
                self?.repositoryResponse(success)
            case .failure(let failure):
                self?.errorResponse(failure)
            }
        }

    }

}
