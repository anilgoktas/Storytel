//
//  BookTableViewCell.swift
//  Storytel
//
//  Created by Anil Goktas on 7/19/21.
//

import UIKit
import SDWebImage

final class BookTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorsLabel: UILabel!
    @IBOutlet private weak var narratorsLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        coverImageView.sd_cancelCurrentImageLoad()
    }
    
    func configure(book: Book) {
        coverImageView.sd_setImage(with: book.coverImageURL, completed: nil)
        titleLabel.text = book.title
        
        authorsLabel.text = "by " + book.authors
            .map { $0.name }
            .joined(separator: ", ")
        narratorsLabel.text = "with " + book.narrators
            .map { $0.name }
            .joined(separator: ", ")
    }
    
}
