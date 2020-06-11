//
//  TableViewCell.swift
//  CustomTableView
//
//  Created by Gustav Vingtoft Andersen on 08/06/2020.
//  Copyright © 2020 Gustav Vingtoft Andersen. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageCell: UIImageView!

    @IBOutlet weak var titleLabel01: UILabel!
    @IBOutlet weak var textLabel02: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
