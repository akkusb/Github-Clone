//
//  UserModel.swift
//  github-repos
//
//  Created by Burhan on 8.08.2020.
//  Copyright © 2020 Burhan. All rights reserved.
//

import UIKit

class UserModel: Codable {
    var id: Int?
    var avatar_url: String?
    var gravatar_id: String?
    var login: String? //Name
    
    var email: String?
}
