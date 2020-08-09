//
//  SearchRepositoryResponseModel.swift
//  github-repos
//
//  Created by Burhan on 8.08.2020.
//  Copyright © 2020 Burhan. All rights reserved.
//

import UIKit

class SearchRepositoryResponseModel: Codable {

    var total_count: Int?
    var items: [RepositoryModel]?
}
