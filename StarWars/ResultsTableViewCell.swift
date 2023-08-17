//
//  ResultsTableViewCell.swift
//  StarWars
//
//  Created by Dmitriy on 16.08.2023.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func settingCell() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        self.clipsToBounds = true
    }

}
