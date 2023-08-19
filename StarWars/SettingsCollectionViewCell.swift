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
    
    
    func settingCellSettingstCollection() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = CGFloat(.cornerRadiusCell)
        self.layer.borderWidth = CGFloat(.borderWidthCell)
        self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        self.clipsToBounds = true
        
        
        //Заглушка!
        imageStarship.image = UIImage(named: .imageXWing)
    }
}
