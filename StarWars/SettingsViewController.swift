//
//  SettingViewController.swift
//  StarWars
//
//  Created by Dmitriy on 02.08.2023.
//

import UIKit

class SettingsViewController: UIViewController {
//MARK: - vars/lets
    var backgroundImage = CALayer()
    let closeViewButton = UIButton(type: .system)
    let saveSettingsButton = UIButton(type: .system)
    var starshipsCollectionView: UICollectionView!
    var playerName = UITextField()
    var stepper = UIStepper()
    var resultLabel = UILabel()

//MARK: - lifecycle func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingSettingsView()
    }
    
//MARK: - flow funcs
    private func settingSettingsView() {
        settingBackgroundView()
        settingButtons(for: [closeViewButton, saveSettingsButton])
        settingCollectionView()
        settingTextFieldName()
        settingStepper()
    }
    
    private func settingCollectionView() {

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: .heightCellSettingsCollectionView, height: .heightCellSettingsCollectionView)
        layout.minimumInteritemSpacing = CGFloat(integerLiteral: .universalConstraint)
        layout.minimumLineSpacing = CGFloat(integerLiteral: .universalConstraint)
        layout.scrollDirection = .horizontal
        
        starshipsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        starshipsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        starshipsCollectionView.delegate = self
        starshipsCollectionView.dataSource = self
        view.addSubview(starshipsCollectionView)
        
        NSLayoutConstraint.activate([
            starshipsCollectionView.topAnchor.constraint(equalTo: view.topAnchor,
                                                        constant: CGFloat(integerLiteral: .topAnchorConstantCollectionView)),
            starshipsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                            constant: CGFloat(integerLiteral: .universalConstraint)),
            starshipsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                             constant: -CGFloat(integerLiteral: .universalConstraint)),
            starshipsCollectionView.bottomAnchor.constraint(equalTo: starshipsCollectionView.topAnchor,
                                                           constant: CGFloat(integerLiteral: .heightSettingsCollectionView))
                ])
        
        starshipsCollectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: .identifireCellSettings)
        starshipsCollectionView.backgroundColor = .clear
    }
    
    func settingTextFieldName() {
        playerName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerName)
        NSLayoutConstraint.activate([
            playerName.topAnchor.constraint(equalTo: starshipsCollectionView.bottomAnchor,
                                                        constant: CGFloat(integerLiteral: .universalConstraint)),
            playerName.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                            constant: CGFloat(integerLiteral: .universalConstraint)),
            playerName.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                             constant: -CGFloat(integerLiteral: .universalConstraint)),
                ])
        
        playerName.backgroundColor = .clear
        playerName.layer.cornerRadius = CGFloat(.cornerRadiusCell)
        playerName.borderStyle = .roundedRect
        playerName.placeholder = .placeholderTextFieldName
        playerName.autocorrectionType = .no
        playerName.layer.borderWidth =  CGFloat(.borderWidthCell)
        playerName.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        playerName.clipsToBounds = true
    }
    
    func settingStepper() {
        stepper.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stepper)
        stepper.minimumValue = 1
        stepper.maximumValue = 3
        stepper.alpha = CGFloat(.alpha)
        
        //Заглушка!!!
        stepper.stepValue = 1
        
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.textAlignment = .left
        resultLabel.font = UIFont(name: .fontName, size: CGFloat(integerLiteral: .sizeFont))

        resultLabel.textColor = .lightGray
        resultLabel.alpha = CGFloat(.alpha)
        resultLabel.textAlignment = .center
        view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            stepper.topAnchor.constraint(equalTo: playerName.bottomAnchor,
                                                        constant: CGFloat(integerLiteral: .universalConstraint)),
            stepper.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                             constant: CGFloat(integerLiteral: .universalConstraint)),
            resultLabel.topAnchor.constraint(equalTo: playerName.bottomAnchor,
                                                        constant: CGFloat(integerLiteral: .universalConstraint)),
            resultLabel.leadingAnchor.constraint(equalTo: stepper.trailingAnchor,
                                                             constant: CGFloat(integerLiteral: .universalConstraint)),
                ])
        updateResultLabel(value: stepper.value)
    }
    
    @objc func stepperValueChanged() {
        updateResultLabel(value: stepper.value)
    }
    
    func updateResultLabel(value: Double) {
        let text: String = .textForLabelResult
        resultLabel.text = "\(text) \(Int(value))"
    }
    


//MARK: - IBActions
    @IBAction func closeView(_ closeViewButton: UIButton) {
       dismiss(animated: true)
    }
    
    @IBAction func saveSettings(_ saveSettingsButton: UIButton) {
        //Заглушка!!!
       dismiss(animated: true)
    }
}

//MARK: - extensions
extension SettingsViewController: ViewProtocol {
    func settingBackgroundView() {
        let image = UIImageView(image: UIImage(named: .imageSpace))
        backgroundImage = image.layer
        view.layer.insertSublayer(backgroundImage, at: 0)
    }
    
    func settingButtons(for buttons: [UIButton]) {
        _ = buttons.map { button in
            button.layer.cornerRadius = CGFloat(.cornerRadiusCell)
            button.layer.borderWidth = CGFloat(.borderWidthCell)
            button.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
            button.clipsToBounds = true
            button.tintColor = .systemGray
            button.layer.cornerRadius = CGFloat(.heightNavigationButton/2)
            let layerButton = button.layer
            
            view.layer.insertSublayer(layerButton, at: 1)
            
            switch button {
            case closeViewButton:
                button.frame = CGRect(x: view.frame.minX + CGFloat(integerLiteral: .universalConstraint),
                                      y: view.frame.minY + CGFloat(integerLiteral: .heightNavigationButton) + CGFloat(integerLiteral: .universalConstraint),
                                         width: CGFloat(integerLiteral: .widthNavigationButton),
                                         height: CGFloat(integerLiteral: .heightNavigationButton))
                button.setImage(UIImage(systemName: .imageMenu), for: [])
                button.addTarget(self, action: #selector(self.closeView(_:)), for: .touchUpInside)
            case saveSettingsButton:
                button.frame = CGRect(x: view.frame.maxX - CGFloat(integerLiteral: .universalConstraint) - CGFloat(integerLiteral: .widthNavigationButton),
                                      y: view.frame.minY + CGFloat(integerLiteral: .heightNavigationButton) + CGFloat(integerLiteral: .universalConstraint),
                                         width: CGFloat(integerLiteral: .widthNavigationButton),
                                         height: CGFloat(integerLiteral: .heightNavigationButton))
                button.setTitle(.titleButtonSaveSettings, for: .normal)
                button.addTarget(self, action: #selector(self.saveSettings(_:)), for: .touchUpInside)
            default:
                print("ups: Button")
            }
        }
    }
}

extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Заглушка!!!
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .identifireCellSettings, for: indexPath) as? SettingsCollectionViewCell ?? SettingsCollectionViewCell()
        
        cell.settingCellSettingstCollection()
        
        return cell
    }
}

extension String {
    static let identifireCellSettings = "identifireCellSettings"
    static let placeholderTextFieldName = "Enter your name"
    static let textForLabelResult = "Game speed:"
    static let titleButtonSaveSettings = "save"
}

extension Int {
    static let heightSettingsCollectionView = 160
    static let topAnchorConstantCollectionView = 120
    static let heightCellSettingsCollectionView = 140
}

