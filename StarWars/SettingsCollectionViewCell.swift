//
//  SettingsCollectionViewCell.swift
//  StarWars
//
//  Created by Dmitriy on 17.08.2023.
//

import UIKit

class SettingsCollectionViewCell: UICollectionViewCell {
    
    let imageStarship: UIImageView = {
        let imageStarship = UIImageView()
        imageStarship.translatesAutoresizingMaskIntoConstraints = false
        return imageStarship
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.addSubview(imageStarship)
        NSLayoutConstraint.activate([
            imageStarship.topAnchor.constraint(equalTo: topAnchor),
            imageStarship.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageStarship.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageStarship.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func settingCellSettingstCollection(imageName: String) {
        self.backgroundColor = .clear
        self.layer.cornerRadius = CGFloat(integerLiteral: .cornerRadiusCell)
        self.layer.borderWidth = CGFloat(integerLiteral: .borderWidthCell)
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.clipsToBounds = true
        
        imageStarship.image = UIImage(named: imageName)
    }
}
