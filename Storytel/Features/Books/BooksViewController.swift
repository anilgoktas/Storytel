//
//  BooksViewController.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import UIKit

final class BooksViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    #warning("TODO: - Implement query header")
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    lazy var viewModel: BooksViewModelProtocol = BooksViewModel()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        viewModel.onBooksUpdate = { [weak self] insertions in
            self?.updateBooks(insertions: insertions)
        }
        viewModel.search(query: "Harry")
    }

}

// MARK: - Configurations

extension BooksViewController {
    
    private func configureTableView() {
        tableView.register(R.nib.bookTableViewCell)
    }
    
    private func updateBooks(insertions: [Int]) {
        if insertions.isEmpty { return }
        let indexPaths = insertions.map { IndexPath(row: $0, section: 0) }
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.endUpdates()
    }
    
}

// MARK: - UITableViewDataSource

extension BooksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.bookTableViewCell, for: indexPath)!
        cell.configure(book: viewModel.books[indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension BooksViewController: UITableViewDelegate {
    
    #warning("TODO: - viewModel.fetchNextPage with UIActivityIndicator")
    
}
