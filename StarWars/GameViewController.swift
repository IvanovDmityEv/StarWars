//
//  ViewController.swift
//  StarWars
//
//  Created by Dmitriy on 28.07.2023.
//

import UIKit

class GameViewController: UIViewController {
    
//MARK: - vars/lets
    var spaseImage = CALayer()
    let leftClickButton = UIButton(type: .system)
    let rightClickButton = UIButton(type: .system)
    let fireButton = UIButton(type: .system)
    let imageRebelStarship = UIImageView()
    var empireStarships: [UIImageView] = []
    var rockets: [UIView] = []
    let closeViewButton = UIButton(type: .system)

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
    
   private func settingSpaceView() {
        settingBackgroundView()
        settingButtons(for: [leftClickButton, rightClickButton, closeViewButton, fireButton])
        settingGameScore()
        addStarships()
    }
    
    private func settingGameScore() {
        let gameScore = UILabel()

        gameScore.text = "SCORE" //передать данные
        gameScore.font = UIFont(name: .fontName, size: CGFloat(integerLiteral: .sizeFont))

        gameScore.textColor = .white
        gameScore.alpha = CGFloat(.alpha)
        gameScore.textAlignment = .center
        
        gameScore.frame =  CGRect(x: Int(view.frame.maxX)/2 - .widthGameScore/2,
                                  y: Int(view.frame.maxY) - .heightGameScore - .universalConstraint,
                                  width: .widthGameScore,
                                  height: .heightGameScore)
        view.addSubview(gameScore)
    }
    
    private func addStarships() {
        guard let imageRebelStarship = self.createStarship(name: .rebelStarship) else { return }
        let layerRebelStarship = imageRebelStarship.layer
        view.layer.insertSublayer(layerRebelStarship, at: 1)

        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            guard let imageEmpireStarship = self.createStarship(name: .empireStarship) else { return }
            //!!!
            self.empireStarships.append(imageEmpireStarship)
            
            let layerEmpireStarship = imageEmpireStarship.layer
            self.view.layer.insertSublayer(layerEmpireStarship, at: 1)
            self.moveEmpireStarship(imageEmpireStarship)
        }
    }

    private func createStarship(name: String) -> UIImageView? {
        let countCell: Int = .countCell
        let widthStarship = Int(view.frame.size.width) / countCell
        var coordinatesX: [CGFloat] = []
        var startPositionX = (self.view.frame.width - CGFloat(widthStarship*countCell))/2
        
        for _ in 0..<countCell {
            coordinatesX.append(startPositionX)
            startPositionX += CGFloat(widthStarship)
        }
        let randomX: Int = Int(coordinatesX.randomElement() ?? startPositionX)
        
        let starships: [String] = [.imageEmpireShip, .imageTieAdvanced, .imageTieFighter, .imageCommandShuttle]
        
        switch name {
        case .empireStarship:
            guard let randomStarsip = starships.randomElement() else { return nil }
            let imageEmpireStarship = UIImageView()
            
            let empireStarship = Starship(positionX: randomX,
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
            
        case .rebelStarship:
            let rebelStarship = Starship(positionX: Int(view.frame.maxX/2) - widthStarship/2,
                                 positionY: Int(view.frame.maxY) - widthStarship * 2 - .universalConstraint,
                                 width: Int(view.frame.width) / .countCell,
                                 height: Int(view.frame.width) / .countCell,
                                 nameStarship: .imageXWing)

            imageRebelStarship.frame = CGRect(x: rebelStarship.positionX,
                                         y: rebelStarship.positionY,
                                         width: rebelStarship.width,
                                         height: rebelStarship.height)
            imageRebelStarship.image = UIImage(named: rebelStarship.name)
            return imageRebelStarship
            
            default:
                print("ups: AddStarship")
        }
        return nil
    }
    
    private func moveEmpireStarship(_ imageEmpireStarship: UIImageView) {
        
        UIView.animate(withDuration: 3, delay: 0, options: .curveLinear) {
            imageEmpireStarship.frame.origin.y += self.imageRebelStarship.frame.origin.y + self.imageRebelStarship.frame.height
            
        } completion: {_ in

            if self.checkCollisionFrame(empireStarshipFrame: imageEmpireStarship.frame, objectFrame: self.imageRebelStarship.frame) {
                self.imageRebelStarship.removeFromSuperview()
                self.showAlert()
            }

        imageEmpireStarship.removeFromSuperview()
            
            //!!!
            if let index = self.empireStarships.firstIndex(of: imageEmpireStarship) {
                self.empireStarships.remove(at: index)
            }
            
        }
    }
    
    private func checkCollisionFrame(empireStarshipFrame: CGRect, objectFrame: CGRect) -> Bool {
        return empireStarshipFrame.intersects(objectFrame)
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: .titleAlert,
                                                message: .messageAlert,
                                                preferredStyle: .alert)
        alertController.view.tintColor = .black
        
        let actionRestart = UIAlertAction(title: .buttonAlertRestart,
                                          style: .default) { [weak self] _ in
            self?.addStarships()
        }
        let actionGoMenu = UIAlertAction(title: .buttonAlertGoToMenu,
                                         style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        alertController.addAction(actionRestart)
        alertController.addAction(actionGoMenu)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func moveRebelStarship(for button: UIButton) {
        let distance = Int(imageRebelStarship.frame.size.width)
        
        UIView.animate(withDuration: 0.3) {
            switch button {
            case self.leftClickButton:
                if self.imageRebelStarship.frame.origin.x - CGFloat(distance) >= self.view.frame.minX {
                    self.imageRebelStarship.frame.origin.x -= CGFloat(distance)
                } else {
                    return
                }
            case self.rightClickButton:
                if self.imageRebelStarship.frame.origin.x + CGFloat(distance) <= self.view.frame.maxX - CGFloat(distance) {
                    self.imageRebelStarship.frame.origin.x += CGFloat(distance)
                } else {
                    return
                }
            default:
                print("ups: rebelStarship")
            }
        }
    }
    
    private func fire(imageStarship: UIImageView) {
        let  rocket = UIView()
        rocket.layer.cornerRadius = CGFloat(.widthRocket)/2
        rocket.backgroundColor = .systemYellow
        let layerRocket = rocket.layer
        self.view.layer.insertSublayer(layerRocket, at: 1)
        rockets.append(rocket)
        switch imageStarship {
        case imageRebelStarship:
            rocket.frame = CGRect(x: Double(imageStarship.frame.origin.x + imageStarship.frame.width/2 - CGFloat(.widthRocket)/2),
                                  y: Double(imageStarship.frame.origin.y - CGFloat(.widthRocket)),
                                  width: CGFloat(.widthRocket),
                                  height: CGFloat(.widthRocket))
            
            UIView.animate(withDuration: 3, delay: 0, options: .curveLinear) {
                rocket.frame.origin.y = self.view.frame.origin.y
                

        } completion: {_ in
//            if self.checkCollisionFrame(empireStarshipFrame: self.imageEmpireStarship.frame, objectFrame: rocket.frame) {
//                self.imageEmpireStarship.removeFromSuperview()
//                rocket.removeFromSuperview()
//            }
            
            rocket.removeFromSuperview()
            
            //!!!
            if let index = self.rockets.firstIndex(of: rocket) {
                self.rockets.remove(at: index)
            }
        }
            //!!!
            checkCollision(rocket: rocket)
            
        default:
            print("ups: fire")
        }
    }
    
    //!!!
    func checkCollision(rocket: UIView) {
         for starship in empireStarships {
             if rocket.frame.intersects(starship.frame) {
                 rocket.removeFromSuperview()
                 starship.removeFromSuperview()
                 
                 if let index = rockets.firstIndex(of: rocket) {
                     rockets.remove(at: index)
                 }
                 if let index = empireStarships.firstIndex(of: starship) {
                     empireStarships.remove(at: index)
                 }
             }
         }
     }
    
    
//MARK: - IBActions
    @IBAction func goToLeft(_ leftClickButton: UIButton) {
        moveRebelStarship(for: leftClickButton)
    }
    @IBAction func goToRight(_ rightClickButton: UIButton) {
        moveRebelStarship(for: rightClickButton)
    }
    @IBAction func closeView(_ closeViewButton: UIButton) {
       dismiss(animated: true)
    }
    @IBAction func fire(_ fireButton: UIButton) {
        fire(imageStarship: imageRebelStarship)
    }
    
}

//MARK: - extensions

extension GameViewController: ViewProtocol {
    func settingBackgroundView() {
        let image = UIImageView(image: UIImage(named: .imageSpace))
        spaseImage = image.layer
        view.layer.insertSublayer(spaseImage, at: 0)
    }
    
    func settingButtons(for buttons: [UIButton]) {
        _ = buttons.map { button in
            
            button.backgroundColor = .black
            button.tintColor = .white
            button.layer.cornerRadius = CGFloat(.heightControllButton/2)
            button.alpha = Double(.alpha)
            let layerButton = button.layer
            view.layer.insertSublayer(layerButton, at: 1)
            
            switch button {
            case leftClickButton:
                button.frame = CGRect(x: view.frame.minX + CGFloat(integerLiteral: .universalConstraint),
                                         y: view.frame.maxY - CGFloat(integerLiteral: .heightControllButton) - CGFloat(integerLiteral: .universalConstraint),
                                         width: CGFloat(integerLiteral: .widthСontrollButton),
                                         height: CGFloat(integerLiteral: .heightControllButton))
                button.setImage(UIImage(systemName: .imageButtonLeftClick), for: [])
                button.addTarget(self, action: #selector(self.goToLeft(_:)), for: .touchUpInside)
            case rightClickButton:
                button.frame = CGRect(x: view.frame.maxX - CGFloat(integerLiteral: .widthСontrollButton) - CGFloat(integerLiteral: .universalConstraint),
                                          y: view.frame.maxY - CGFloat(integerLiteral: .heightControllButton) - CGFloat(integerLiteral: .universalConstraint),
                                          width: CGFloat(integerLiteral: .widthСontrollButton),
                                          height: CGFloat(integerLiteral: .heightControllButton))
                button.setImage(UIImage(systemName: .imageButtonRightClick), for: [])
                button.addTarget(self, action: #selector(self.goToRight(_:)), for: .touchUpInside)
                
            case closeViewButton:
                button.frame = CGRect(x: view.frame.minX + CGFloat(integerLiteral: .universalConstraint),
                                      y: view.frame.minY + CGFloat(integerLiteral: .heightNavigationButton) + CGFloat(integerLiteral: .universalConstraint),
                                         width: CGFloat(integerLiteral: .widthNavigationButton),
                                         height: CGFloat(integerLiteral: .heightNavigationButton))
                button.layer.cornerRadius = CGFloat(.widthNavigationButton/2)
                button.setImage(UIImage(systemName: .imageMenu), for: [])
                button.addTarget(self, action: #selector(self.closeView(_:)), for: .touchUpInside)
                
            case fireButton:
                button.frame = CGRect(x: view.frame.maxX - CGFloat(integerLiteral: .widthСontrollButton) - CGFloat(integerLiteral: .universalConstraint),
                                          y: view.frame.maxY - 2*CGFloat(integerLiteral: .heightControllButton) - 2*CGFloat(integerLiteral: .universalConstraint),
                                          width: CGFloat(integerLiteral: .widthСontrollButton),
                                          height: CGFloat(integerLiteral: .heightControllButton))
                button.setImage(UIImage(systemName: .imageButtonFire), for: [])
                button.addTarget(self, action: #selector(self.fire(_:)), for: .touchUpInside)
            default:
                print("ups: Button")
            }
        }
    }
}

extension String {
    static let imageDeathStar = "deathStar"
    static let imageEmpireShip = "empireShip"
    static let imageTieAdvanced = "tieAdvanced"
    static let imageTieFighter = "tieFighter"
    static let imageCommandShuttle = "commandShuttle"
    static let imageXWing = "xWing"
    static let imageRebellionShip = "rebellionShip"
    static let imageSpace = "space"
    
    static let empireStarship = "empireStarship"
    static let rebelStarship = "rebelStarship"
    
    static let imageButtonLeftClick = "arrowshape.left"
    static let imageButtonRightClick = "arrowshape.right"
    static let imageButtonFire =  "smallcircle.fill.circle"
    
    static let fontName = "Futura Bold"
    
    static let titleAlert = "Mission failed"
    static let messageAlert = "You were shot down by an imperial fighter"
    static let buttonAlertRestart = "Restart"
    static let buttonAlertGoToMenu = "Menu"
}

extension Int {
    static let widthСontrollButton = 60
    static let heightControllButton = 60
    
    static let universalConstraint = 16
    
    static let widthGameScore = 100
    static let heightGameScore = 60
    
    static let countCell = 5
    
    static let sizeFont = 26
    
}

extension Double {
    
    static let alpha = 0.5
    static let widthRocket = 10.0
    
}


