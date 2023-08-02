//
//  ViewController.swift
//  StarWars
//
//  Created by Dmitriy on 28.07.2023.
//

import UIKit

class SpaceViewController: UIViewController {
    
//MARK: - vars/lets
    var spaseImage = CALayer()
    let leftClickButton = UIButton(type: .system)
    let rightClickButton = UIButton(type: .system)
    let imageXwing = UIImageView()

//MARK: - lifecycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        settingSpaceView()
    }
    
    override func viewDidLayoutSubviews() {
        spaseImage.frame = CGRect(x: view.frame.origin.x,
                                  y: view.frame.origin.y,
                                  width: view.bounds.size.width ,
                                  height: view.bounds.size.height)
    }

//MARK: - flow funcs
    
    func settingSpaceView() {
        settingBackgroundView()
        settingButtons(for: [leftClickButton, rightClickButton])
        settingGameScore()
        addStarships()
    }
    
    func settingGameScore() {
        let gameScore = UILabel()

        gameScore.text = "SCORE" //передать данные
        gameScore.font = UIFont(name: .fontName, size: CGFloat(integerLiteral: .sizeFont))

        gameScore.textColor = .white
        gameScore.alpha = 0.5
        gameScore.textAlignment = .center
        
        gameScore.frame =  CGRect(x: Int(view.frame.maxX)/2 - .widthGameScore/2,
                                  y: Int(view.frame.maxY) - .heightGameScore - .buttomConstraint,
                                  width: .widthGameScore,
                                  height: .heightGameScore)
        view.addSubview(gameScore)
    }
    
    func addStarships() {
        guard let imageXwing = self.createStarship(name: .xWing) else { return }
        let layerXwing = imageXwing.layer
        view.layer.insertSublayer(layerXwing, at: 1)

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
        guard let starship = self.createStarship(name: .empireStarship) else { return }
            let layerStarship = starship.layer
            self.view.layer.insertSublayer(layerStarship, at: 2)
            self.moveEmpireStarship(starship)
        }
    }
    
    private func moveEmpireStarship(_ imageStarship: UIImageView) {
        UIView.animate(withDuration: 3, delay: 0.0, options: .curveLinear) {
            imageStarship.frame.origin.y += self.view.frame.height + imageStarship.frame.height
        } completion: {_ in
            imageStarship.removeFromSuperview()
        }
    }

    func createStarship(name: String) -> UIImageView? {
        let widthStarship = Int(view.frame.size.width) / .countCell
        let randomX: Double = .random(in: self.view.frame.origin.x...self.view.frame.width - CGFloat(widthStarship))
        let starships: [String] = [.deathStar, .empireShip, .rebellionShip, .tieAdvanced, .tieFighter]
        
        switch name {
        case .empireStarship:
            guard let randomStarsip = starships.randomElement() else { return nil }
            let imageEmpireStarship = UIImageView()
            
            let empireStarship = Starship(positionX: Int(randomX),
                                 positionY: Int(view.frame.minY) - widthStarship,
                                 width: Int(view.frame.width) / .countCell,
                                 height: Int(view.frame.width) / .countCell,
                                 nameStarship: randomStarsip)
            
            imageEmpireStarship.frame = CGRect(x: empireStarship.positionX,
                                         y: empireStarship.positionY,
                                         width: empireStarship.width,
                                         height: empireStarship.height)
            imageEmpireStarship.image = UIImage(named: empireStarship.name)
            return imageEmpireStarship
            
        case .xWing:
            let xWing = Starship(positionX: Int(view.frame.maxX/2) - widthStarship/2,
                                 positionY: Int(view.frame.maxY) - widthStarship * 2 - .buttomConstraint,
                                 width: Int(view.frame.width) / .countCell,
                                 height: Int(view.frame.width) / .countCell,
                                 nameStarship: .xWing)
            
            imageXwing.frame = CGRect(x: xWing.positionX,
                                         y: xWing.positionY,
                                         width: xWing.width,
                                         height: xWing.height)
            imageXwing.image = UIImage(named: xWing.name)
            return imageXwing
            
            default:
                print("ups: AddStarship")
        }
        return nil
    }
    
    func moveXwing(for button: UIButton) {
        let distance = Int(imageXwing.frame.size.width)
        
        UIView.animate(withDuration: 0.3) {
            switch button {
            case self.leftClickButton:
                if self.imageXwing.frame.origin.x - CGFloat(distance) >= self.view.frame.minX {
                    self.imageXwing.frame.origin.x -= CGFloat(distance)
                } else {
                    return
                }
            case self.rightClickButton:
                if self.imageXwing.frame.origin.x + CGFloat(distance) <= self.view.frame.maxX - CGFloat(distance) {
                    self.imageXwing.frame.origin.x += CGFloat(distance)
                } else {
                    return
                }
            default:
                print("ups: moveXwing")
            }
        }
    }
    
    
//MARK: - IBActions
    @IBAction func goToLeft(_ leftClickButton: UIButton) {
        moveXwing(for: leftClickButton)
    }
    @IBAction func goToRight(_ rightClickButton: UIButton) {
        moveXwing(for: rightClickButton)
    }
}



//MARK: - extensions

extension SpaceViewController: SettingViewProtocol {
    func settingBackgroundView() {
        let image = UIImageView(image: UIImage(named: .space))
        spaseImage = image.layer
        view.layer.insertSublayer(spaseImage, at: 0)
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
            case leftClickButton:
                button.frame = CGRect(x: view.frame.minX + CGFloat(integerLiteral: .buttomConstraint),
                                         y: view.frame.maxY - CGFloat(integerLiteral: .heightControllButton) - CGFloat(integerLiteral: .buttomConstraint),
                                         width: CGFloat(integerLiteral: .widthСontrollButton),
                                         height: CGFloat(integerLiteral: .heightControllButton))
                button.setImage(UIImage(systemName: .imageButtonLeftClick), for: [])
                button.addTarget(self, action: #selector(self.goToLeft(_:)), for: .touchUpInside)
            case rightClickButton:
                button.frame = CGRect(x: view.frame.maxX - CGFloat(integerLiteral: .widthСontrollButton) - CGFloat(integerLiteral: .buttomConstraint),
                                          y: view.frame.maxY - CGFloat(integerLiteral: .heightControllButton) - CGFloat(integerLiteral: .buttomConstraint),
                                          width: CGFloat(integerLiteral: .widthСontrollButton),
                                          height: CGFloat(integerLiteral: .heightControllButton))
                button.setImage(UIImage(systemName: .imageButtonRightClick), for: [])
                button.addTarget(self, action: #selector(self.goToRight(_:)), for: .touchUpInside)
            default:
                print("ups: Button")
            }
        }
    }
}

extension String {
    static let deathStar = "deathStar"
    static let empireShip = "empireShip"
    static let rebellionShip = "rebellionShip"
    static let tieAdvanced = "tieAdvanced"
    static let tieFighter = "tieFighter"
    static let empireStarship = "empireStarship"
    static let xWing = "xWing"
    static let space = "space"
    
    static let imageButtonLeftClick = "arrowshape.left"
    static let imageButtonRightClick = "arrowshape.right"
    
    static let fontName = "Futura Bold"
}

extension Int {
    static let widthСontrollButton = 60
    static let heightControllButton = 60
    
    static let buttomConstraint = 16
    
    static let widthGameScore = 100
    static let heightGameScore = 60
    
    static let countCell = 5
    
    static let sizeFont = 26
}



