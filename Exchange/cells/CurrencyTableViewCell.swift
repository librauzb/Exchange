//
//  CurrencyTableViewCell.swift
//  Exchange
//
//  Created by Mac on 2021/03/15.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var buyCourseLbl: UILabel!
    @IBOutlet weak var sellCourse: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
