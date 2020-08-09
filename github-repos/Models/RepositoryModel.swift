//
//  RepositoryModel.swift
//  github-repos
//
//  Created by Burhan on 8.08.2020.
//  Copyright © 2020 Burhan. All rights reserved.
//

import UIKit

class RepositoryModel: Codable {
    
    var owner: UserModel?
    var name: String?
    
    var id: Int?
    var node_id: String?
    var full_name: String?
    var description: String?
    var html_url: String?
    var forks_count: Int?
    var default_branch: String?
    var language: String?
}
