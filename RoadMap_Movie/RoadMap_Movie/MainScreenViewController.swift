// MainScreenViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стартовый экран приложения
final class MainScreenViewController: UIViewController {
    // MARK: - Constans

    private enum Constants {
        enum MovieSections {
            static let topRated = "Высокий рейтинг"
            static let popular = "Популярное"
            static let actual = "Актуально"
        }

        enum URL {
            static let topRatedURL =
                "https://api.themoviedb.org/3/movie/top_rated?api_key=5cc552e34f7eb492b6f65e0e324d397b&language=ru-RU"
            static let popularURL = "https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=ru-RU"
            static let actualURL = "https://api.themoviedb.org/3/movie/latest?api_key=<<api_key>>&language=ru-RU"
        }

        static let movieCell = "movieCell"
        static let error = "error"
    }

    // MARK: - Private properties

    private let sessionConfiguration = URLSessionConfiguration.default
    private let decoder = JSONDecoder()
    private let session = URLSession.shared
    private var movies: Results?

    // MARK: - Private visual elements

    private let tableView = UITableView()
    private let movieImageView = UIImageView()
    private lazy var selectTopRatedMoviesListButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.MovieSections.topRated, for: .normal)
        button.tag = 0
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(changeMoviesListAction), for: .touchUpInside)
        return button
    }()

    private lazy var selectPopularMoviesListButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.MovieSections.popular, for: .normal)
        button.tag = 1
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(changeMoviesListAction), for: .touchUpInside)
        return button
    }()

    private lazy var selectLatestMoviesListButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.MovieSections.actual, for: .normal)
        button.tag = 2
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(changeMoviesListAction), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        obtainMovies(
            url: Constants.URL.topRatedURL
        )
        setupUI()
    }

    // MARK: - Private methods

    @objc private func changeMoviesListAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            obtainMovies(
                url: Constants.URL.topRatedURL
            )
        case 1:
            obtainMovies(url: Constants.URL.popularURL)
        case 2:
            obtainMovies(url: Constants.URL.actualURL)
        default:
            return
        }
    }

    private func setupUI() {
        view.addSubview(selectTopRatedMoviesListButton)
        view.addSubview(selectPopularMoviesListButton)
        view.addSubview(selectLatestMoviesListButton)
        selectTopRatedMoviesListButton.translatesAutoresizingMaskIntoConstraints = false
        selectPopularMoviesListButton.translatesAutoresizingMaskIntoConstraints = false
        selectLatestMoviesListButton.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            selectTopRatedMoviesListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectTopRatedMoviesListButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33),
            selectTopRatedMoviesListButton.heightAnchor.constraint(equalToConstant: 50),
            selectTopRatedMoviesListButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            selectPopularMoviesListButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33),
            selectPopularMoviesListButton.heightAnchor.constraint(equalToConstant: 50),
            selectPopularMoviesListButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            selectPopularMoviesListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            selectLatestMoviesListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectLatestMoviesListButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33),
            selectLatestMoviesListButton.heightAnchor.constraint(equalToConstant: 50),
            selectLatestMoviesListButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Constants.movieCell)
    }

    private func obtainMovies(url: String) {
        guard let url =
            URL(
                string: url
            ) else { return }
        URLSession.shared.fetchData(at: url) { result in
            switch result {
            case let .success(moviesAPI):
                self.movies = moviesAPI.self
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure:
                print(Constants.error)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies?.results.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Constants.movieCell, for: indexPath) as? MovieTableViewCell
        else { return UITableViewCell() }
        guard let movie = movies?.results[indexPath.row] else { return UITableViewCell() }
        cell.setupCell(movie)
        return cell
    }
}
