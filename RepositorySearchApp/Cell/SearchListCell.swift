//
//  SearchListCell.swift
//  RepositorySearchApp
//
//  Created by 陳韋綸 on 2023/10/20.
//

import UIKit
import SDWebImage

class SearchListCell: UITableViewCell {

    static let identifier = "SearchListCell"

    private let produceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let produceTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.text = "title"
        return label
    }()

    private let produceSubtitle:  UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "subtitle"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setData(_ data: RepositoryModel) {
        DispatchQueue.main.async { [weak self] in
            self?.produceImage.sd_setImage(with: data.owner?.avatar_url)
            self?.produceTitle.text = data.full_name
            self?.produceSubtitle.text = data.description
        }
    }

    private func setView() {

        contentView.addSubview(produceImage)
        contentView.addSubview(produceTitle)
        contentView.addSubview(produceSubtitle)

    }

    private func setLayout() {

        [
            produceImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            produceImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            produceImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            produceImage.heightAnchor.constraint(equalToConstant: 80),
            produceImage.widthAnchor.constraint(equalToConstant: 80),
        ].forEach({
            $0.isActive = true
        })

        [
            produceTitle.bottomAnchor.constraint(equalTo: contentView.centerYAnchor),
            produceTitle.leftAnchor.constraint(equalTo: produceImage.rightAnchor, constant: 15),
            produceTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15)
        ].forEach({
            $0.isActive = true
        })

        [
            produceSubtitle.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            produceSubtitle.leftAnchor.constraint(equalTo: produceImage.rightAnchor, constant: 15),
            produceSubtitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15)
        ].forEach({
            $0.isActive = true
        })

    }

}
