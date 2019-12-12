//
//  AppDelegate.swift
//  test
//  Copyright © 2019 BENNOUR EL FAHSI. All rights reserved.
//

import UIKit
import CoreData

class TableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var bookNameLabel: UILabel!
  
    @IBOutlet weak var bookImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func configureCell(book:Book){
        bookNameLabel.text = book.name

        let imageData = book.image!
        
        if let url = NSURL(string: imageData),
            let data = NSData(contentsOf: url as URL){
            bookImageView.image = UIImage(data: data as Data)

        }
    }

}
