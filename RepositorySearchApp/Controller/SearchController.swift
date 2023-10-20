//
//  ViewController.swift
//  RepositorySearchApp
//
//  Created by 陳韋綸 on 2023/10/20.
//

import UIKit

class SearchController: UIViewController {

    // MARK: ViewModel
    private let searchViewModel = SearchViewModel()

    // MARK: View
    private let searchListView = SearchListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHandle()
        setNav()
        setView()
    }

    private func setView() {
        view.addSubview(searchListView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .always
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setLayout()
    }

    private func setLayout() {

        [
            searchListView.topAnchor.constraint(equalTo: view.topAnchor),
            searchListView.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchListView.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ].forEach({
            $0.isActive = true
        })

    }

    private func setNav() {

        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "Repository Search"
        let barAppearance = UINavigationBarAppearance()
        barAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        barAppearance.backgroundColor = .black.withAlphaComponent(0.8)
        barAppearance.shadowImage = nil
        barAppearance.shadowColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = barAppearance

    }

    private func setAlert() {
        let alertController = UIAlertController(title: "Oops", message: "The data couldn't be read because it is missing.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alertController, animated: true)
    }

}

// MARK: Handle
extension SearchController {

    private func setupHandle() {

        searchViewModel.repositoryResponse = { [weak self] reponse in
            self?.searchListView.setData(reponse.items ?? [])
        }

        searchViewModel.errorResponse = { error in
            print(error)
        }

        searchListView.searchCompletion = { [weak self] text in
            if let text = text,
               !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                self?.searchViewModel.searchRepositoryApiBinding(q: text)
            }
            else {
                DispatchQueue.main.async {
                    self?.setAlert()
                }
            }
        }

        searchListView.tapCellCompletion = { [weak self] repository in
            DispatchQueue.main.async {
                let detailView = DetailController()
                detailView.setData(repository)
                self?.navigationController?.pushViewController(detailView, animated: true)
            }
        }

    }

}
