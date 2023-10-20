//
//  DetailView.swift
//  RepositorySearchApp
//
//  Created by 陳韋綸 on 2023/10/20.
//

import UIKit

class DetailView: UIView {

    private let produceTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .medium)
        label.textColor = .black
        return label
    }()

    private let produceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let produceName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()

    private let produceLanguage:  UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        return label
    }()

    private let produceStars:  UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private let produceWatchs:  UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private let produceForks:  UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private let produceIssues:  UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [produceStars, produceWatchs, produceForks, produceIssues])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = 8
        return stackView
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

    public func setData(_ data: RepositoryModel) {
        produceTitle.text = data.owner?.login
        produceImage.sd_setImage(with: data.owner?.avatar_url)
        produceName.text = data.full_name
        produceLanguage.text = "Written in " + "\(data.language ?? "")"
        produceStars.text = "\(data.stargazers_count ?? 0)" + " stars"
        produceWatchs.text = "\(data.watchers_count ?? 0)" + " watchers"
        produceForks.text = "\(data.forks_count ?? 0)" + " forks"
        produceIssues.text =  "\(data.open_issues_count ?? 0)" + " open issues"
    }

    private func setView() {
        addSubview(produceTitle)
        addSubview(produceImage)
        addSubview(produceName)
        addSubview(produceLanguage)
        addSubview(stackView)
    }

    private func setLayout() {

        [
            produceTitle.topAnchor.constraint(equalTo: topAnchor),
            produceTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            produceTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: 20),
        ].forEach({
            $0.isActive = true
        })

        [
            produceImage.topAnchor.constraint(equalTo: produceTitle.bottomAnchor, constant: 0),
            produceImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            produceImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            produceImage.widthAnchor.constraint(equalToConstant: Width - 30),
        ].forEach({
            $0.isActive = true
        })

        [
            produceName.topAnchor.constraint(equalTo: produceImage.bottomAnchor, constant: 20),
            produceName.centerXAnchor.constraint(equalTo: centerXAnchor),
            produceName.widthAnchor.constraint(equalToConstant: Width - 100),
        ].forEach({
            $0.isActive = true
        })

        [
            produceLanguage.topAnchor.constraint(equalTo: produceName.bottomAnchor, constant: 30),
            produceLanguage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            produceLanguage.rightAnchor.constraint(equalTo: stackView.leftAnchor, constant: -30),
        ].forEach({
            $0.isActive = true
        })

        [
            stackView.topAnchor.constraint(equalTo: produceLanguage.topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        ].forEach({
            $0.isActive = true
        })

    }

}
