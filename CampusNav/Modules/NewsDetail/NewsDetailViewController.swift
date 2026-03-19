//
//  NewsDetailViewController.swift
//  CampusNav
//
//  Created by Nikita on 13.03.2026.
//

import UIKit
import SnapKit

final class NewsDetailViewController: UIViewController {

    private let newsItem: MainNewsItem

    private let imageContainerView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.17, green: 0.39, blue: 0.84, alpha: 0.08)
        element.layer.cornerRadius = 20
        return element
    }()

    private let imageView: UIImageView = {
        let element = UIImageView()
        element.tintColor = UIColor(red: 0.17, green: 0.39, blue: 0.84, alpha: 1.0)
        element.contentMode = .scaleAspectFit
        return element
    }()

    private let titleLabel: UILabel = {
        let element = UILabel()
        element.font = .boldSystemFont(ofSize: 28)
        element.numberOfLines = 0
        return element
    }()

    private let detailsLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 17)
        element.textColor = .secondaryLabel
        element.numberOfLines = 0
        return element
    }()

    private let scrollView: UIScrollView = {
        let element = UIScrollView()
        return element
    }()

    private let contentView: UIView = {
        let element = UIView()
        return element
    }()

    init(newsItem: MainNewsItem) {
        self.newsItem = newsItem
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configure()
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Подробнее"

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.add(subviews: imageContainerView, titleLabel, detailsLabel)
        imageContainerView.addSubview(imageView)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        imageContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(220)
        }

        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 84, height: 84))
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageContainerView.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20)
        }
    }

    private func configure() {
        imageView.image = UIImage(systemName: newsItem.imageSystemName)
        titleLabel.text = newsItem.title
        detailsLabel.text = newsItem.details
    }
}
