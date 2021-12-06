//
//  CustomCell.swift
//  Proyecto
//
//  Created by mac16 on 05/12/21.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var ProductsViews: UIView!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var preciolbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
