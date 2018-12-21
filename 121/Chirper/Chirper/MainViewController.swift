//
//  MainViewController.swift
//  Chirper
//
//  Created by Andy Ron on 2018/11/10.
//  Copyright © 2018 Andy Ron. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var emptyView: UIView!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var errorView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    let searchController = UISearchController(searchResultsController: nil)
    let networkingService = NetworkingService()
    let darkGreen = UIColor(red: 11/255, green: 86/255, blue: 14/255, alpha: 1)
    var recordings: [Recording]?
    var error: Error?
//    var isLoading = false
    
    var state = State.loading {
        didSet {
            setFooterView()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Chirper"
        activityIndicator.color = darkGreen
        prepareNavigationBar()
        prepareSearchBar()
        prepareTableView()
        loadRecordings()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.searchBar.becomeFirstResponder()
    }
    
    @objc func loadRecordings() {
        state = .loading
        loadPage(1)
    }
    
    func update(response: RecordingsResult) {

        if let error = response.error {
            state = .error(error)
            return
        }
        
        guard let newRecordings = response.recordings, !newRecordings.isEmpty else {
            state = .empty
            return
        }
        
        var allRecordings = state.currentRecordings
        allRecordings.append(contentsOf: newRecordings)
        if response.hasMorePages {
            state = .paging(allRecordings, next: response.nextPage)
        } else {
            state = .populated(allRecordings)
        }
    }
    
    func prepareSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        
        let whiteTitleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let textFieldInSearchBar = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        textFieldInSearchBar.defaultTextAttributes = whiteTitleAttributes
        
        navigationItem.searchController = searchController
        searchController.searchBar.becomeFirstResponder()
    }
    
    func prepareNavigationBar() {
        navigationController?.navigationBar.barTintColor = darkGreen
        
        let whiteTitleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = whiteTitleAttributes
    }
    
    func prepareTableView() {
        tableView.dataSource = self
        
        let nib = UINib(nibName: BirdSoundTableViewCell.NibName, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: BirdSoundTableViewCell.ReuseIdentifier)
    }
    
    func setFooterView() {
        switch state {
        case .loading:
            tableView.tableFooterView = loadingView
        case .error(let error):
            errorLabel.text = error.localizedDescription
            tableView.tableFooterView = errorView
        case .empty:
            tableView.tableFooterView = emptyView
        case .populated:
            tableView.tableFooterView = nil
        case .paging:
            tableView.tableFooterView = loadingView
        }
    }
    
    func loadPage(_ page: Int) {
        setFooterView()
        recordings = []
        tableView.reloadData()
        
        let query = searchController.searchBar.text
        networkingService.fetchRecordings(matching: query, page: page) { [weak self] response in
            
            guard let `self` = self else {
                return
            }
            
            self.searchController.searchBar.endEditing(true)
            self.update(response: response)
        }
    }
}


extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(MainViewController.loadRecordings), object: nil)
        
        perform(#selector(MainViewController.loadRecordings), with: nil, afterDelay: 0.5)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.currentRecordings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BirdSoundTableViewCell.ReuseIdentifier) as? BirdSoundTableViewCell else {
            return UITableViewCell()
        }
        
//        if let recordings = recordings {
//            cell.load(recording: recordings[indexPath.row])
//        }
        cell.load(recording: state.currentRecordings[indexPath.row])
        
        if case .paging(_, let nextPage) = state, indexPath.row == state.currentRecordings.count - 1 {
            loadPage(nextPage)
        }
        
        return cell
    }
}

enum State {
    case loading
    case populated([Recording])
    case empty
    case error(Error)
    case paging([Recording], next: Int)
    
    var currentRecordings: [Recording] {
        switch self {
        case .populated(let recordings):
            return recordings
        case .paging(let recordings, next: _):
            return recordings
        default:
            return []
        }
    }
}
