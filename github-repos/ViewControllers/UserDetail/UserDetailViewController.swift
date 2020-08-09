//
//  UserDetailViewController.swift
//  github-repos
//
//  Created by Burhan on 8.08.2020.
//  Copyright © 2020 Burhan. All rights reserved.
//

import UIKit

enum UserDetailTableSections: Int {
    case UserInfo = 0
    case UserRepositories = 1
}

class UserDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var dispatchGroup = DispatchGroup()
    var user: UserModel?
    var repositories: [RepositoryModel]?
    
    let pageSize = 20
    var pageNumber = 1
    var isRepositoriesLoading: Bool = false
    var isRepositoriesLoadMoreEnabled: Bool = true
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func initialize() {
        self.title = "User Detail"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.registerCells()
        
        self.dispatchGroup.notify(queue: DispatchQueue.main) {
            self.hideHud()
            self.tableView.reloadData()
        }
        
        self.loadUser()
    }
    
    func registerCells() {
        self.tableView.register(UINib.init(nibName: "UserInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "UserInfoTableViewCell")
        self.tableView.register(UINib.init(nibName: "UserRepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "UserRepositoryTableViewCell")
    }

    func loadUser() {
        guard let username = self.user?.login else { return }
        self.showHud()
        self.dispatchGroup.enter()
        UserService.getUserDetail(username: username, success: { [weak self] (userModel) in
            self?.dispatchGroup.leave()
            self?.user = userModel
            self?.tableView.reloadData()
        }) { [weak self] (error) in
            self?.dispatchGroup.leave()
        }
        self.dispatchGroup.enter()
        UserService.getUserRepositories(username: username, success: { [weak self] (repositories) in
            self?.pageNumber = 2
            self?.dispatchGroup.leave()
            self?.repositories = repositories
            self?.tableView.reloadData()
        }) { [weak self] (error) in
            self?.dispatchGroup.leave()
        }
    }
    
    func loadUserRepositoriesMore() {
        guard self.isRepositoriesLoading == false, self.isRepositoriesLoadMoreEnabled else { return }
        guard let username = self.user?.login else { return }
        self.isRepositoriesLoading = true
        self.showHud()
        UserService.getUserRepositories(username: username, pageNumber: self.pageNumber, pageSize: self.pageSize, success: { [weak self] (repositories) in
            if repositories.count > 0 {
                self?.repositories?.append(contentsOf: repositories)
                self?.tableView.reloadData()
                self?.pageNumber += 1
            }
            else {
                self?.isRepositoriesLoadMoreEnabled = false
            }
            self?.hideHud()
            self?.isRepositoriesLoading = false
            
        }) { [weak self] (error) in
            self?.hideHud()
            self?.isRepositoriesLoading = false
        }
    }

    // MARK: TableView Delegate & Datasource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentSection = UserDetailTableSections.init(rawValue: indexPath.section) else { return UITableViewCell() }
        switch currentSection {
            case .UserInfo:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as? UserInfoTableViewCell else { return UITableViewCell() }
                if let user = self.user {
                    cell.refresh(user: user)
                }
                return cell
            case .UserRepositories:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserRepositoryTableViewCell", for: indexPath) as? UserRepositoryTableViewCell else { return UITableViewCell() }
                if let currentRepository = self.repositories?[indexPath.row] {
                    cell.refresh(repository: currentRepository)
                }
                
                if indexPath.row > (self.repositories?.count ?? 0) - 5 {
                    self.loadUserRepositoriesMore()
                }
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentSection = UserDetailTableSections.init(rawValue: indexPath.section) else { return }
        switch currentSection {
            case .UserInfo:
                return
            case .UserRepositories:
                if let currentRepository = self.repositories?[indexPath.row] {
                    Router.pushRepositoryDetail(repository: currentRepository)
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentSection = UserDetailTableSections.init(rawValue: section) else { return 0 }
        switch currentSection {
            case .UserInfo:
                return 1
            case .UserRepositories:
                return self.repositories?.count ?? 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
