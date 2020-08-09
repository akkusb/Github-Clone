//
//  SearchRepositoryViewController.swift
//  github-repos
//
//  Created by Burhan on 8.08.2020.
//  Copyright © 2020 Burhan. All rights reserved.
//

import UIKit

class SearchRepositoryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let pageSize = 20
    var pageNumber = 1
    var isRepositoriesLoading: Bool = false
    var isRepositoriesLoadMoreEnabled: Bool = true
    var lastSearchText: String? = nil
    
    var searchRepositoryResponseModel: SearchRepositoryResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func initialize() {
        self.title = "Search Repository"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.registerCells()
        
        self.searchBar.becomeFirstResponder()
    }
    
    func registerCells() {
        self.tableView.register(UINib.init(nibName: "SearchRepositoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchRepositoryTableViewCell")
    }
    
    func searchRepository(searchText: String, isLoadMore: Bool = false) {
        self.lastSearchText = searchText
        if isLoadMore == false {
            self.pageNumber = 1
            self.isRepositoriesLoadMoreEnabled = true
        }
        else {
            guard self.isRepositoriesLoadMoreEnabled, self.isRepositoriesLoading == false else {
                return
            }
        }
        self.isRepositoriesLoading = true
        self.showHud()
        SearchService.searchRepository(searchText: searchText, pageNumber: self.pageNumber, pageSize: self.pageSize, success: { [weak self] (searchRepositoryResponseModel) in
            if isLoadMore {
                if let newItems = searchRepositoryResponseModel.items {
                    self?.searchRepositoryResponseModel?.items?.append(contentsOf: newItems)
                }
                else {
                    self?.isRepositoriesLoadMoreEnabled = false
                }
            }
            else {
                self?.searchRepositoryResponseModel = searchRepositoryResponseModel
            }
            self?.pageNumber += 1
            self?.isRepositoriesLoading = false
            self?.tableView.reloadData()
            self?.hideHud()
        }) { [weak self] (error) in
            self?.isRepositoriesLoading = false
            self?.hideHud()
        }
    }
    
    // MARK: SearchBar Delegate Methods
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchRepository(searchText: searchBar.text ?? "")
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        self.searchBar.resignFirstResponder()
    }
    
    // MARK: TableView Delegate & Datasource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchRepositoryTableViewCell", for: indexPath) as? SearchRepositoryTableViewCell else { return UITableViewCell() }
        
        if let currentRepository = self.searchRepositoryResponseModel?.items?[indexPath.row] {
            cell.refresh(repository: currentRepository)
        }
        
        if indexPath.row > (self.searchRepositoryResponseModel?.items?.count ?? 0) - 5 {
            if let lastSearchText = self.lastSearchText {
                self.searchRepository(searchText: lastSearchText, isLoadMore: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currentRepository = self.searchRepositoryResponseModel?.items?[indexPath.row] {
            Router.pushRepositoryDetail(repository: currentRepository)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchRepositoryResponseModel?.items?.count ?? 0
    }
}
