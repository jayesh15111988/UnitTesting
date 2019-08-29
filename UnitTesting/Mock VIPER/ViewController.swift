//
//  ViewController.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit


struct ViewModel {
    let id: String
    let username: String
    let address: String
}

protocol ViewInput: AnyObject {
    func set(with viewModels: [ViewModel])
    func showError(with message: String)
}

class ViewController: UIViewController {

    let tableView = UITableView(frame: .zero)
    let refreshButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Refresh", for: .normal)
        button.addTarget(self, action: #selector(refreshList), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    let infoButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Info", for: .normal)
        button.addTarget(self, action: #selector(displayInfo), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = .red
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var viewOutput: ViewOutput?
    var viewModels: [ViewModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSubviews()
        configureLayout()
        activityIndicator.startAnimating()
        viewOutput?.getEmployeesWithPromise(with: baseURL)

        // MARK: For Testing Purpose
        let numberScalar = NumberScaler(screenRect: UIScreen.main.bounds)
        print(numberScalar.scale(with: 2))
    }

    func configureSubviews() {
        self.view.addSubview(refreshButton)
        self.view.addSubview(infoButton)
        self.view.addSubview(tableView)
        self.view.addSubview(activityIndicator)
        self.view.backgroundColor = .white
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
    }

    func configureLayout() {
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        // MARK: TableView Constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: refreshButton.bottomAnchor, constant: 44),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])

        // MARK: Activity Indicator Constraints
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])

        // MARK: Refresh and Info button Constraints
        NSLayoutConstraint.activate([
            refreshButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoButton.leadingAnchor.constraint(equalTo: refreshButton.trailingAnchor, constant: 44.0),
            infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            refreshButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            infoButton.topAnchor.constraint(equalTo: refreshButton.topAnchor),
            infoButton.bottomAnchor.constraint(equalTo: refreshButton.bottomAnchor),
            refreshButton.heightAnchor.constraint(equalToConstant: 64.0),
            ])
    }

    @objc func refreshList() {
        activityIndicator.startAnimating()
        viewOutput?.refreshListTapped()
    }

    @objc func displayInfo() {
        viewOutput?.trackDisplayInfo()
        let alertController = UIAlertController(title: "Showing Information", message:
            "This is a default message as a part of information", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: ViewInput {
    func set(with viewModels: [ViewModel]) {
        self.activityIndicator.stopAnimating()
        self.viewModels = viewModels
        tableView.reloadData()
    }

    func showError(with message: String) {
        self.activityIndicator.stopAnimating()
        let alertController = UIAlertController(title: "Error", message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        guard let viewModel = viewModels?[indexPath.row] else {
            fatalError("Failed to get the valid View Model at index \(indexPath.row)")
        }
        cell.apply(viewModel: viewModel)
        return cell
    }


}
