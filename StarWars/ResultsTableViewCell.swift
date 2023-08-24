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
                playerName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(integerLiteral: .universalConstraint)),
                
                result.centerYAnchor.constraint(equalTo: centerYAnchor),
                result.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat(integerLiteral: .universalConstraint)),

                imageStarship.centerYAnchor.constraint(equalTo: centerYAnchor),
                imageStarship.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageStarship.heightAnchor.constraint(equalTo: heightAnchor),
                imageStarship.widthAnchor.constraint(equalTo: heightAnchor),
            ])
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
//MARK: - flow funcs
    func settingCellResultsTable(indexPath: IndexPath) {
        self.backgroundColor = .clear
        self.layer.cornerRadius = CGFloat(integerLiteral: .cornerRadiusCell)
        self.layer.borderWidth = CGFloat(integerLiteral: .borderWidthCell)
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.clipsToBounds = true
        
        let savedResults = ResultsGame.getResults()
        let sortedResults = savedResults.sorted { $0.gamePoints > $1.gamePoints }
        playerName.text = sortedResults[indexPath.row].name
        imageStarship.image = UIImage(named: sortedResults[indexPath.row].starship)
        result.text = String(sortedResults[indexPath.row].gamePoints)
    }
}
