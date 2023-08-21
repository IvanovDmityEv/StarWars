//
//  ResultsTableViewCell.swift
//  StarWars
//
//  Created by Dmitriy on 16.08.2023.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

//MARK: - vars/lets
    private let playerName: UILabel = {
        let playerName = UILabel()
        playerName.translatesAutoresizingMaskIntoConstraints = false
        return playerName
    }()
    
    private let result: UILabel = {
        let result = UILabel()
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }()
    
    private let imageStarship: UIImageView = {
        let imageStarship = UIImageView()
        imageStarship.translatesAutoresizingMaskIntoConstraints = false
        return imageStarship
    }()

//MARK: - lifecycle func
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubview(playerName)
            addSubview(result)
            addSubview(imageStarship)
            
            NSLayoutConstraint.activate([
                
                playerName.centerYAnchor.constraint(equalTo: centerYAnchor),
                playerName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                
                result.centerYAnchor.constraint(equalTo: centerYAnchor),
                result.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

                imageStarship.centerYAnchor.constraint(equalTo: centerYAnchor),
                imageStarship.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageStarship.heightAnchor.constraint(equalTo: heightAnchor),
                imageStarship.widthAnchor.constraint(equalTo: heightAnchor),
            ])
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//MARK: - flow funcs
    func settingCellResultdTable() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = CGFloat(integerLiteral: .cornerRadiusCell)
        self.layer.borderWidth = CGFloat(integerLiteral: .borderWidthCell)
        self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        self.clipsToBounds = true
        
        //Заглушка!!!
        playerName.text = "Valera"
        result.text = "20"
        imageStarship.image = UIImage(named: .imageXWing)
    }
}
