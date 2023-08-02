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
    func settingStartView() {
        settingBackgroundView()
        settingButtons(for: [startButton, resultsButton, settingsButton])
    }

    
//MARK: - IBActions
    @IBAction func startGame(_ startButton: UIButton) {
       
    }
    @IBAction func showResuits(_ resultsButton: UIButton) {
       
    }
    @IBAction func showSettings(_ settingsButton: UIButton) {
       
    }
}

//MARK: - extensions
extension StartViewController: SettingViewProtocol {
    func settingBackgroundView() {
        let image = UIImageView(image: UIImage(named: .space))
        backgroundImage = image.layer
        view.layer.insertSublayer(backgroundImage, at: 0)
    }
    
    func settingButtons(for buttons: [UIButton]) {
        _ = buttons.map { button in
            button.backgroundColor = .black
            button.tintColor = .white
            button.layer.cornerRadius = CGFloat(.widthСontrollButton/2)
            button.alpha = 0.5
            let layerButton = button.layer
            view.layer.insertSublayer(layerButton, at: 1)
            view.addSubview(button)
            
            switch button {
            case startButton:
                button.frame = CGRect(x: view.frame.minX + CGFloat(integerLiteral: .buttomConstraint),
                                         y: view.frame.maxY - CGFloat(integerLiteral: .heightControllButton) - CGFloat(integerLiteral: .buttomConstraint),
                                         width: CGFloat(integerLiteral: .widthСontrollButton),
                                         height: CGFloat(integerLiteral: .heightControllButton))
                button.setImage(UIImage(systemName: .imageButtonStart), for: [])
                button.addTarget(self, action: #selector(self.startGame(_:)), for: .touchUpInside)
                button.setTitle(.nameButtonStart, for: .normal)
                
            case resultsButton:
                button.frame = CGRect(x: (view.frame.width - CGFloat(integerLiteral: .widthMenuStartButton))/2,
                                      y: view.frame.height/2,
                                          width: CGFloat(integerLiteral: .widthMenuStartButton),
                                          height: CGFloat(integerLiteral: .heightMenuStartButton))
                button.setImage(UIImage(systemName: .imageButtonResults), for: [])
                button.addTarget(self, action: #selector(self.showResuits(_:)), for: .touchUpInside)
                button.setTitle(.nameButtonResults, for: .normal)
            
            case settingsButton:
                button.frame = CGRect(x: (view.frame.width - CGFloat(integerLiteral: .widthMenuStartButton))/2,
                                      y: view.frame.height/2,
                                          width: CGFloat(integerLiteral: .widthMenuStartButton),
                                          height: CGFloat(integerLiteral: .heightMenuStartButton))
                button.setImage(UIImage(systemName: .imageButtonSettings), for: [])
                button.addTarget(self, action: #selector(self.showResuits(_:)), for: .touchUpInside)
                button.setTitle(.nameButtonSettings, for: .normal)
            
            default:
                print("ups: Button")
            }
        }
    }
}

extension String {
    static let nameButtonStart = "START"
    static let nameButtonResults = "RESULTS"
    static let nameButtonSettings = "SETTINGS"
    
    static let imageButtonStart = "gamecontroller"
    static let imageButtonResults = "person.3"
    static let imageButtonSettings = "gearshape"
}

extension Int {
    static let widthMenuStartButton = 300
    static let heightMenuStartButton = 60
}


