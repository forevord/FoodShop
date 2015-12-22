//
//  CategoryTableViewCell.swift
//  FoodShop
//
//  Created by Pavel Salkevich on 15.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var CategoryImage: UIImageView!
    @IBOutlet weak var titleCategory: UILabel!
    @IBOutlet weak var imageToCategory: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
