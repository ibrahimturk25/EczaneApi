//
//  pharmacyTableViewCell.swift
//  BorsApp
//
//  Created by İbrahim Türk on 24.10.2023.
//

import UIKit

class pharmacyTableViewCell: UITableViewCell {
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var buttonMapOutlet: UIButton!
    @IBOutlet weak var labelMap: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

