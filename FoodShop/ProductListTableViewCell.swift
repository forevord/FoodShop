//
//  ProductListTableViewCell.swift
//  FoodShop
//
//  Created by Pavel Salkevich on 21.12.15.
//  Copyright © 2015 Pavel Salkevich. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    @IBOutlet weak var productListImage: UIImageView!
    @IBOutlet weak var productListTitle: UILabel!
    @IBOutlet weak var productListWeight: UILabel!
    @IBOutlet weak var productListCost: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
