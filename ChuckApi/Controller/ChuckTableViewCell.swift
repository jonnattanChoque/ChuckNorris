//
//  ChuckTableViewCell.swift
//  ChuckApi
//
//  Created by jonnattan Choque on 23/11/21.
//

import UIKit

class ChuckTableViewCell: UITableViewCell {

    @IBOutlet weak var imageChuck: UIImageView!
    @IBOutlet weak var labelChuck: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func display(object: ChuckModel) {
        imageChuck.load(urlSting: object.icon_url)
        labelChuck.text = object.value
    }
    
}
