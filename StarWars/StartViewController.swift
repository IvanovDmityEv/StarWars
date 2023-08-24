//
//  StartViewController.swift
//  StarWars
//
//  Created by Dmitriy on 02.08.2023.
//

import UIKit

class StartViewController: UIViewController {

//MARK: - vars/lets
    var backgroundImage = CALayer()
    let startButton = UIButton(type: .system)
    let resultsButton = UIButton(type: .system)
    let settingsButton = UIButton(type: .system)
    
//MARK: - lifecycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        settingStartView()
    }
    
    override func viewDidLayoutSubviews() {
        backgroundImage.frame = CGRect(x: view.frame.origin.x,
                                  y: view.frame.origin.y,
                                  width: view.bounds.size.width ,
                                  height: view.bounds.size.height)
    }
    
//MARK: - flow funcs
    private func settingStartView() {
        settingBackgroundView()
        settingButtons(for: [startButton, resultsButton, settingsButton])
    }

    
//MARK: - IBActions
    @IBAction func startGame(_ startButton: UIButton) {
        let gameVC = GameViewController()
        gameVC.modalPresentationStyle = .fullScreen
        present(gameVC, animated: true)
    }
    @IBAction func showResults(_ resultsButton: UIButton) {
        let resultsVC = ResultsViewController()
        resultsVC.modalPresentationStyle = .fullScreen
        present(resultsVC, animated: true)
    }
    @IBAction func showSettings(_ settingsButton: UIButton) {
        let settingsVC = SettingsViewController()
        settingsVC.modalPresentationStyle = .fullScreen
        present(settingsVC, animated: true)
    }
}

//MARK: - extensions
extension StartViewController: ViewProtocol {
    func settingBackgroundView() {
        let image = UIImageView(image: UIImage(named: .imageSpace))
        backgroundImage = image.layer
        view.layer.insertSublayer(backgroundImage, at: 0)
    }
    
    func settingButtons(for buttons: [UIButton]) {
        _ = buttons.map { button in
            button.backgroundColor = .black
            button.tintColor = .white
            button.layer.cornerRadius = CGFloat(integerLiteral: .heightMenuStartButton/2)
            button.alpha = CGFloat(.alpha)
            let layerButton = button.layer
            view.layer.insertSublayer(layerButton, at: 1)
            
            switch button {
            case startButton:
                button.frame = CGRect(x: (view.frame.width - CGFloat(integerLiteral: .widthMenuStartButton))/2,
                                      y: view.frame.height/2 - CGFloat(integerLiteral: .heightMenuStartButton) - CGFloat(integerLiteral: .universalConstraint),
                                      width: CGFloat(integerLiteral: .widthMenuStartButton),
                                      height: CGFloat(integerLiteral: .heightMenuStartButton))
                button.setImage(UIImage(systemName: .imageButtonStart), for: [])
                button.addTarget(self, action: #selector(self.startGame(_:)), for: .touchUpInside)
                button.setTitle(.nameButtonGame, for: .normal)
                
            case resultsButton:
                button.frame = CGRect(x: (view.frame.width - CGFloat(integerLiteral:.widthMenuStartButton))/2,
                                      y: view.frame.height/2,
                                      width: CGFloat(integerLiteral: .widthMenuStartButton),
                                      height: CGFloat(integerLiteral: .heightMenuStartButton))
                button.setImage(UIImage(systemName: .imageButtonResults), for: [])
                button.addTarget(self, action: #selector(self.showResults(_:)), for: .touchUpInside)
                button.setTitle(.nameButtonResults, for: .normal)
            
            case settingsButton:
                button.frame = CGRect(x: (view.frame.width - CGFloat(integerLiteral:.widthMenuStartButton))/2,
                                      y: view.frame.height/2 + CGFloat(integerLiteral: .heightMenuStartButton) + CGFloat(integerLiteral: .universalConstraint),
                                      width: CGFloat(integerLiteral: .widthMenuStartButton),
                                      height: CGFloat(integerLiteral: .heightMenuStartButton))
                button.setImage(UIImage(systemName: .imageButtonSettings), for: [])
                button.addTarget(self, action: #selector(self.showSettings(_:)), for: .touchUpInside)
                button.setTitle(.nameButtonSettings, for: .normal)
            
            default:
                print("ups: Button")
            }
        }
    }
}
