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
    var arrayStarships: [String] = []
    
//    var settingsTuple: (Int?, String?, Int?)
    var indexSelectedStarship: Int?
    var settings = GameSettings.shared
    
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
                                                         constant: CGFloat( integerLiteral: .topAnchorConstantCollectionView)),
            starshipsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                             constant: CGFloat( integerLiteral: .universalConstraint)),
            starshipsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                              constant: -CGFloat( integerLiteral: .universalConstraint)),
            starshipsCollectionView.bottomAnchor.constraint(equalTo: starshipsCollectionView.topAnchor,
                                                            constant: CGFloat( integerLiteral: .heightSettingsCollectionView))
                ])
        
        starshipsCollectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: .identifireCellSettings)
        starshipsCollectionView.backgroundColor = .clear
        arrayStarships = [.imageXWing, .imageMilleniumFalcon, .imageRebellionShip]
    }
    
    func settingTextFieldName() {
        playerName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerName)
        NSLayoutConstraint.activate([
            playerName.topAnchor.constraint(equalTo: starshipsCollectionView.bottomAnchor,
                                            constant: CGFloat( integerLiteral: .universalConstraint)),
            playerName.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: CGFloat( integerLiteral: .universalConstraint)),
            playerName.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -CGFloat( integerLiteral: .universalConstraint)),
                ])
        
        playerName.backgroundColor = .clear
        playerName.layer.cornerRadius = CGFloat(integerLiteral: .cornerRadiusCell)
        playerName.borderStyle = .roundedRect
        playerName.placeholder = .placeholderTextFieldName
        playerName.autocorrectionType = .no
        playerName.layer.borderWidth =  CGFloat(integerLiteral: .borderWidthCell)
        playerName.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        playerName.clipsToBounds = true
        playerName.delegate = self
        if settings.namePlayer != nil, settings.namePlayer != "" {
            playerName.text = settings.namePlayer
        }
    }
    
    private func settingStepper() {
        stepper.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stepper)
        stepper.minimumValue = 1
        stepper.maximumValue = 3
        stepper.alpha = CGFloat(.alpha)
        
        
        stepper.value = Double(settings.speedGame ?? 1)
        
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
                                         constant: CGFloat( integerLiteral: .universalConstraint)),
            stepper.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                             constant: CGFloat( integerLiteral: .universalConstraint)),
            resultLabel.topAnchor.constraint(equalTo: playerName.bottomAnchor,
                                             constant: CGFloat( integerLiteral: .universalConstraint)),
            resultLabel.leadingAnchor.constraint(equalTo: stepper.trailingAnchor,
                                                 constant: CGFloat( integerLiteral: .universalConstraint)),
                ])
        updateResultLabel(value: stepper.value)
    }
    
    @objc func stepperValueChanged() {
        updateResultLabel(value: stepper.value)
//        settingsTuple.2 = Int(stepper.value)
    }
    
    private func updateResultLabel(value: Double) {
        let text: String = .textForLabelResult
        resultLabel.text = "\(text) \(Int(value))"
    }
    
    private func showAlertError() {
        let alertController = UIAlertController(title: .titleAlertError,
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.view.tintColor = .black
        
        let actionOk = UIAlertAction(title: .buttonOkAlertError,
                                         style: .default)
        
        alertController.addAction(actionOk)
        self.present(alertController, animated: true, completion: nil)
    }
    


//MARK: - IBActions
    @IBAction func closeView(_ closeViewButton: UIButton) {
       dismiss(animated: true)
    }
    
    @IBAction func saveSettings(_ saveSettingsButton: UIButton) {
        view.endEditing(true)
//        if settingsTuple.1 != nil, settingsTuple.1 != "" {
//            settings.indexStarship = settingsTuple.0 ?? 0
//            settings.namePlayer = settingsTuple.1
//            settings.speedGame = settingsTuple.2 ?? 1
//            dismiss(animated: true)
        if playerName.text != nil, playerName.text != "" {
            settings.indexStarship = indexSelectedStarship
            settings.namePlayer = playerName.text
            settings.speedGame = Int(stepper.value)
            dismiss(animated: true)
        } else {
            showAlertError()
        }
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
            button.layer.cornerRadius = CGFloat(integerLiteral: .cornerRadiusCell)
            button.layer.borderWidth = CGFloat(integerLiteral: .borderWidthCell)
            button.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
            button.clipsToBounds = true
            button.tintColor = .systemGray
            button.layer.cornerRadius = CGFloat(.heightNavigationButton/2)
            let layerButton = button.layer
            
            view.layer.insertSublayer(layerButton, at: 1)
            
            switch button {
            case closeViewButton:
                button.frame = CGRect(x: view.frame.minX + CGFloat(integerLiteral: .universalConstraint),
                                      y: view.frame.minY + CGFloat( integerLiteral: .heightNavigationButton) + CGFloat( integerLiteral: .universalConstraint),
                                      width: CGFloat( integerLiteral: .widthNavigationButton),
                                      height: CGFloat( integerLiteral: .heightNavigationButton))
                button.setImage(UIImage(systemName: .imageButtonMenu), for: [])
                button.addTarget(self, action: #selector(self.closeView(_:)), for: .touchUpInside)
            case saveSettingsButton:
                button.frame = CGRect(x: view.frame.maxX - CGFloat(integerLiteral: .universalConstraint) - CGFloat( integerLiteral: .widthNavigationButton),
                                      y: view.frame.minY + CGFloat( integerLiteral: .heightNavigationButton) + CGFloat( integerLiteral: .universalConstraint),
                                      width: CGFloat( integerLiteral: .widthNavigationButton),
                                      height: CGFloat( integerLiteral: .heightNavigationButton))
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
        arrayStarships.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .identifireCellSettings, for: indexPath) as? SettingsCollectionViewCell ?? SettingsCollectionViewCell()
        
        cell.settingCellSettingstCollection(imageName: arrayStarships[indexPath.row])

        let idexSelectStarship = settings.indexStarship
        if indexPath.row == idexSelectStarship {
            let indexPathToSelect = IndexPath(row: indexPath.row, section: indexPath.section)
            cell.contentView.backgroundColor = UIColor.systemGray5.withAlphaComponent(CGFloat(.alpha))
            collectionView.selectItem(at: indexPathToSelect, animated: true, scrollPosition: .centeredHorizontally)
            indexSelectedStarship = indexPath.row
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.systemGray5.withAlphaComponent(CGFloat(.alpha))
            indexSelectedStarship = indexPath.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.clear
        }
    }
}

extension SettingsViewController: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let enteredText = textField.text {
//            settingsTuple.1 = enteredText
//        }
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
