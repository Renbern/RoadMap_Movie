// MovieTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка фильма
final class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    private enum Constants {
        static let baseURL = "https://image.tmdb.org/t/p/w200/"
        static let stringFormat = "%.1f"
    }
    
    // MARK: - Private visual elements

    private let movieTitleLabel: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 15, weight: .bold)
        return title
    }()

    private let markLabel: UILabel = {
        let mark = UILabel()
        mark.backgroundColor = .systemGreen
        mark.alpha = 0.8
        mark.layer.cornerRadius = 25
        mark.clipsToBounds = true
        mark.textAlignment = .center
        mark.font = .systemFont(ofSize: 15, weight: .semibold)
        return mark
    }()

    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    private let overviewLabel: UILabel = {
        let overview = UILabel()
        overview.lineBreakMode = .byWordWrapping
        overview.numberOfLines = 0
        overview.font = .systemFont(ofSize: 12)
        overview.textAlignment = .justified
        return overview
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        markLabel.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(posterImageView)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(markLabel)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private methods

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            posterImageView.heightAnchor.constraint(equalToConstant: 200),
            posterImageView.widthAnchor.constraint(equalToConstant: 150),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

            movieTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 15),
            movieTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 30),

            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 15),
            overviewLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 5),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            markLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -55),
            markLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -5),
            markLabel.heightAnchor.constraint(equalToConstant: 50),
            markLabel.widthAnchor.constraint(equalToConstant: 50),

        ])
    }

    // MARK: - Public methods

    func setupCell(_ movie: Movies) {
        movieTitleLabel.text = movie.title
        overviewLabel.text = movie.overview
        guard let imageURL = URL(string: Constants.baseURL + "\(movie.poster)") else { return }
        posterImageView.load(url: imageURL)
        let movieRating = String(format: Constants.stringFormat, movie.mark)
        markLabel.text = movieRating
    }
}
