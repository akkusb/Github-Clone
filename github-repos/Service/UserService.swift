//
//  UserService.swift
//  github-repos
//
//  Created by Burhan on 8.08.2020.
//  Copyright © 2020 Burhan. All rights reserved.
//

import UIKit

class UserService: BaseService {

    static func getUserDetail(username: String, pageNumber: Int = 1, pageSize: Int = 20, success: @escaping (_ repositoryOwnerModel:UserModel) -> Void, failure: @escaping (_ errorModel:ErrorModel?) -> Void) -> Void {
        let url = baseUrl + "/users/\(username)"
        let parameters: [String : Any] = ["per_page":pageSize, "page":pageNumber]
        
        BaseService.get(url: url, parameters: parameters, success: { (responseData) in
            
            guard let baseResponse = responseData else {
                failure(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseModel:UserModel = try decoder.decode(UserModel.self, from: baseResponse)
                success(responseModel)
            }
            catch {
                failure(ErrorModel())
            }
            
        }) { (error) in
            failure(error)
        }
    }
    
    static func getUserRepositories(username: String, pageNumber: Int = 1, pageSize: Int = 20, success: @escaping (_ userRepositories:[RepositoryModel]) -> Void, failure: @escaping (_ errorModel:ErrorModel?) -> Void) -> Void {
        let url = baseUrl + "/users/\(username)/repos"
        let parameters: [String : Any] = ["per_page":pageSize, "page":pageNumber]
        
        BaseService.get(url: url, parameters: parameters, success: { (responseData) in
            
            guard let baseResponse = responseData else {
                failure(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseModel:[RepositoryModel] = try decoder.decode([RepositoryModel].self, from: baseResponse)
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
