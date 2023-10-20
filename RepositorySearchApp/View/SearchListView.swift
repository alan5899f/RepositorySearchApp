//
//  SearchListView.swift
//  RepositorySearchApp
//
//  Created by 陳韋綸 on 2023/10/20.
//

import UIKit

class SearchListView: UIView {

    public var searchCompletion: (String?) -> Void = { text in }

    public var tapCellCompletion: (RepositoryModel) -> Void = { repository in }

    private var repositoryData: [RepositoryModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.searchTableView.reloadData()
            }
        }
    }

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 8, y: 0, width: Width - 16, height: 50))
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "請輸入關鍵字搜尋"
        searchBar.showsScopeBar = true
        return searchBar
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didRefrash), for: .valueChanged)
        return refreshControl
    }()

    private lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchListCell.self, forCellReuseIdentifier: SearchListCell.identifier)
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
        let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: Width, height: 50))
        tableHeaderView.addSubview(searchBar)
        tableView.tableHeaderView = tableHeaderView
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        setView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    public func setData(_ data: [RepositoryModel]) {
        repositoryData = data
    }

    private func setView() {
        addSubview(searchTableView)
    }

    private func setLayout() {

        [
            searchTableView.topAnchor.constraint(equalTo: topAnchor),
            searchTableView.leftAnchor.constraint(equalTo: leftAnchor),
            searchTableView.rightAnchor.constraint(equalTo: rightAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ].forEach({
            $0.isActive = true
        })

    }
    
}

// MARK: Handle
extension SearchListView {

    @objc private func didRefrash() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.searchCompletion(self?.searchBar.text)
            self?.refreshControl.endRefreshing()
        }
        
    }

}

// MARK: UISearchBar Delegate
extension SearchListView: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchCompletion(searchBar.text)
    }

}

// MARK: UITableView Delegate
extension SearchListView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchListCell.identifier, for: indexPath) as? SearchListCell else {
            return UITableViewCell()
        }
        cell.setData(repositoryData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryData.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tapCellCompletion(repositoryData[indexPath.row])
    }

}
