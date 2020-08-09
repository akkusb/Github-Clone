//
//  RepositoryDetailViewController.swift
//  github-repos
//
//  Created by Burhan on 8.08.2020.
//  Copyright © 2020 Burhan. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: BaseViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var defaultBranchLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    
    var repository: RepositoryModel? {
        didSet {
            if self.isViewLoaded {
                self.refresh()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func initialize() {
        self.title = "Repository Detail"
        self.refresh()
    }
    
    func refresh() {
        if let avatarUrlString = self.repository?.owner?.avatar_url, let avatarUrl = URL.init(string: avatarUrlString) {
            self.avatarImageView.af.setImage(withURL: avatarUrl)
        }
        self.usernameLabel.text = self.repository?.owner?.login
        self.emailLabel.text = self.repository?.owner?.email
        
        self.repositoryNameLabel.text = "Repository name: \(self.repository?.name ?? "")"
        self.languageLabel.text = "Language:  \(self.repository?.language ?? "")"
        self.defaultBranchLabel.text = "Default Branch: \(self.repository?.default_branch ?? "")"
        self.forkCountLabel.text = "Fork Count: \(self.repository?.forks_count ?? 0)"
    }

    @IBAction func avatarButtonAction(_ sender: Any) {
        if let user = self.repository?.owner {
            Router.pushUserDetail(user: user)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
