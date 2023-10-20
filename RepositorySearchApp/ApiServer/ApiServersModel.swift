//
//  ApiServersModel.swift
//  GoBusNow
//
//  Created by alan on 2023/7/16.
//

import SwiftUI

protocol ApiServersProtocol: ObservableObject {
    func requestHttpServer<T: Decodable>(completion: @escaping (Result<[T], Error>) -> Void)
}

class ApiServersModel: ApiServersProtocol {

    let api: ApiRouter
    let method: ApiMethod
    let queryItems: [ApiBodyItem]

    init(api: ApiRouter, method: ApiMethod = .GET, queryItems: [ApiBodyItem] = []) {
        self.api = api
        self.method = method
        self.queryItems = queryItems
    }
    
    func requestHttpServer<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {

        let baseURL = Base_URL + api.rawValue

        guard let requestURL = buildGETRequestURL(withQueryItems: queryItems, baseURL: baseURL) else {
            completion(.failure(ApiError.RequestUrlError("RequestUrl 錯誤")))
           return
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(Api_Token)", forHTTPHeaderField: "Authorization")
        request.setValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")

        urlSession(request: request, completion: completion)
    }

    private func buildGETRequestURL(withQueryItems queryItems: [ApiBodyItem], baseURL: String) -> URL? {
        let Item = queryItems.compactMap { item in
            return "\(item.key)=\(item.value)"
        }.joined(separator: "&")
        let url = (baseURL + "?" + Item).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return URL(string: url ?? "") ?? URL(string: "")
    }

    private func urlSession<T: Decodable>(request: URLRequest,completion: @escaping (Result<T, Error>) -> Void) {

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(ApiError.DataTaskError("URLSession 錯誤")))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(ApiError.ResponseNullError("Response 資料為空")))
                return
            }

            if response.statusCode == 200 {
                guard let data = data else {
                    completion(.failure(ApiError.DataNullError("Data 資料為空")))
                    return
                }
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(json))
                }
                catch {
                    completion(.failure(ApiError.JsonError("Json 資料結構錯誤")))
                }
            }
            else {
                completion(.failure(ApiError.ResponseError("Response 請求響應錯誤")))
            }
        }
        dataTask.resume()


    }
}

