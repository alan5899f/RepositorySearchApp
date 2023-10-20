//
//  DetailController.swift
//  RepositorySearchApp
//
//  Created by 陳韋綸 on 2023/10/20.
//

import UIKit

class DetailController: UIViewController {

    // MARK: View
    private let detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white
        setView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setLayout()
    }

    private func setView() {
        view.addSubview(detailView)
    }

    private func setLayout() {

        [
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ].forEach({
            $0.isActive = true
        })

    }

    public func setData(_ data: RepositoryModel) {
        detailView.setData(data)
    }

}

