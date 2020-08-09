//
//  SearchRepositoryTableViewCell.swift
//  github-repos
//
//  Created by Burhan on 8.08.2020.
//  Copyright © 2020 Burhan. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchRepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    
    var repository: RepositoryModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func refresh(repository: RepositoryModel) {
        self.repository = repository
        if let avatarUrlString = repository.owner?.avatar_url, let avatarUrl = URL.init(string: avatarUrlString) {
            self.avatarImageView.af.setImage(withURL: avatarUrl)
        }
        self.repositoryNameLabel.text = repository.name
        self.usernameLabel.text = repository.owner?.login
    }
    
    @IBAction func avatarButtonAction(_ sender: Any) {
        if let user = self.repository?.owner {
            Router.pushUserDetail(user: user)
        }
    }
    
    override func prepareForReuse() {
        self.repository = nil
        self.avatarImageView.image = nil
        self.usernameLabel.text = ""
        self.repositoryNameLabel.text = ""
    }
    
}
