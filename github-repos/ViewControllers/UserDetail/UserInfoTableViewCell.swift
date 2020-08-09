//
//  UserInfoTableViewCell.swift
//  github-repos
//
//  Created by Burhan on 8.08.2020.
//  Copyright © 2020 Burhan. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var user: UserModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refresh(user: UserModel) {
        self.user = user
        if let avatarUrlString = user.avatar_url, let avatarUrl = URL.init(string: avatarUrlString) {
            self.avatarImageView.af.setImage(withURL: avatarUrl)
        }
        self.usernameLabel.text = user.login
        self.emailLabel.text = user.email
    }
    
    override func prepareForReuse() {
        self.user = nil
        self.avatarImageView.image = nil
        self.usernameLabel.text = ""
        self.emailLabel.text = ""
    }
    
}
