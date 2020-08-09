//
//  SearchService.swift
//  github-repos
//
//  Created by Burhan on 8.08.2020.
//  Copyright © 2020 Burhan. All rights reserved.
//

import UIKit

class SearchService: BaseService {

    static func searchRepository(searchText: String = "", pageNumber: Int = 1, pageSize: Int = 20, success: @escaping (_ searchRepositoryResponseModel:SearchRepositoryResponseModel) -> Void, failure: @escaping (_ errorModel:ErrorModel?) -> Void) -> Void {
        let url = baseUrl + "/search/repositories"
        let parameters: [String : Any] = ["q":searchText, "per_page":pageSize, "page":pageNumber]
        
        BaseService.get(url: url, parameters: parameters, success: { (responseData) in
            
            guard let baseResponse = responseData else {
                failure(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseModel:SearchRepositoryResponseModel = try decoder.decode(SearchRepositoryResponseModel.self, from: baseResponse)
                success(responseModel)
            }
            catch {
                failure(ErrorModel())
            }
            
        }) { (error) in
            failure(error)
        }
    }
}
