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


//MARK: - lifecycle func
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingSettingsView()
    }
    
    
//MARK: - flow funcs
    private func settingSettingsView() {
        settingBackgroundView()
        settingButtons(for: [closeViewButton])
    }
    

//MARK: - IBActions
    @IBAction func closeView(_ closeViewButton: UIButton) {
       dismiss(animated: true)
    }
}

//MARK: - extensions
extension SettingsViewController: SettingViewProtocol {
    func settingBackgroundView() {
        let image = UIImageView(image: UIImage(named: .imageSpace))
        backgroundImage = image.layer
        view.layer.insertSublayer(backgroundImage, at: 0)
    }
    
    func settingButtons(for buttons: [UIButton]) {
        _ = buttons.map { button in
            button.backgroundColor = .black
            button.tintColor = .white
            button.layer.cornerRadius = CGFloat(.heightCloseWiewButton/2)
            button.alpha = Double(.alpha)
            let layerButton = button.layer
            
            view.layer.insertSublayer(layerButton, at: 1)
            
            switch button {
            case closeViewButton:
                button.frame = CGRect(x: view.frame.minX + CGFloat(integerLiteral: .buttomConstraint),
                                      y: view.frame.minY + CGFloat(integerLiteral: .heightCloseWiewButton) + CGFloat(integerLiteral: .buttomConstraint),
                                         width: CGFloat(integerLiteral: .widthCloseWiewButton),
                                         height: CGFloat(integerLiteral: .heightCloseWiewButton))
                button.setImage(UIImage(systemName: .imageMenu), for: [])
                button.addTarget(self, action: #selector(self.closeView(_:)), for: .touchUpInside)
            default:
                print("ups: Button")
            }
        }
    }
    
    
}
