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
    
    var settings = GameSettings.shared

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
        
        gameScore.frame = CGRect(x: Int(view.frame.maxX)/2 - .widthGameScore/2,
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
            self.view.layer.insertSublayer(layerEmpireStarship, at: 2)
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
            let positionY = view.frame.maxY - leftClickButton.frame.height - CGFloat(integerLiteral: .universalConstraint) - CGFloat(widthStarship)
            let rebelStarship = Starship(positionX: Int(view.frame.maxX/2) - widthStarship/2,
                                         positionY: Int(positionY),
                                 width: Int(view.frame.width) / .countCell,
                                 height: Int(view.frame.width) / .countCell,
                                 nameStarship: .imageXWing)
//
            imageRebelStarship.frame = CGRect(x: rebelStarship.positionX,
                                         y: rebelStarship.positionY,
                                         width: rebelStarship.width,
                                         height: rebelStarship.height)
            let namesRebelStarships: [String] = [.imageXWing, .imageMilleniumFalcon, .imageRebellionShip]
            let selectedRebelStarship = namesRebelStarships[settings.indexStarship ?? 0]
            
            imageRebelStarship.image = UIImage(named: selectedRebelStarship)
            
            return imageRebelStarship
            
            default:
                print("ups: AddStarship")
        }
        return nil
    }
    
    private func moveEmpireStarship(_ imageEmpireStarship: UIImageView) {
        
//        let animator = UIViewPropertyAnimator(duration: 3, curve: .linear){
//            imageEmpireStarship.frame.origin.y += self.imageRebelStarship.frame.origin.y + self.imageRebelStarship.frame.height
//        }
//
//
//
//        animator.addCompletion { position in
//            if position == .end {
//                print("jsdhfskdhf")
//                if self.checkCollisionFrame(empireStarshipFrame: imageEmpireStarship.frame, objectFrame: self.imageRebelStarship.frame) {
//                    self.imageRebelStarship.removeFromSuperview()
//                    self.showAlert()
//
//                }
//            }
//            imageEmpireStarship.removeFromSuperview()
//        }
//
//        animator.startAnimation()
//
//        let countIteration = Int((view.frame.maxY - leftClickButton.frame.height - CGFloat(integerLiteral: .universalConstraint))/imageEmpireStarship.frame.height)

//        animator.fractionComplete = CGFloat(0.5)

        
        
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
            self?.empireStarships = []
            self?.rockets = []
            
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
        rocket.layer.cornerRadius = CGFloat(integerLiteral: .widthRocket)/2
        rocket.backgroundColor = .systemRed

        let layerRocket = rocket.layer
        self.view.layer.insertSublayer(layerRocket, at: 2)
        rockets.append(rocket)
        switch imageStarship {
        case imageRebelStarship:
            rocket.frame = CGRect(x: CGFloat(Int(imageStarship.frame.origin.x + imageStarship.frame.width/2 - CGFloat(integerLiteral: .widthRocket)/2)),
                                  y: CGFloat(Int(imageStarship.frame.origin.y)) - CGFloat(integerLiteral: .widthRocket),
                                  width: CGFloat(integerLiteral: .widthRocket),
                                  height: CGFloat(integerLiteral: .widthRocket))
            
            let countIteration = (Int(rocket.frame.origin.y) - Int(self.view.frame.origin.y))/Int(imageStarship.frame.height)
            
            UIView.animate(withDuration: 3, delay: 0, options: .curveLinear) {
                
                for _ in 0...countIteration {
                    rocket.frame.origin.y -= imageStarship.frame.height
                    self.checkCollision(rocket: rocket)
                }
                
//                rocket.frame.origin.y = self.view.frame.origin.y
//                rocket.center = CGPoint(x: rocket.center.x, y: -rocket.bounds.height / 2)
        } completion: {_ in
            
            //!!!
            if let index = self.rockets.firstIndex(of: rocket) {
                self.rockets.remove(at: index)
            }
            rocket.removeFromSuperview()
        }
            //!!!
//            checkCollision(rocket: rocket)
            
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
                                      y: view.frame.minY + CGFloat(integerLiteral: .heightNavigationButton) + CGFloat( integerLiteral: .universalConstraint),
                                      width: CGFloat( integerLiteral: .widthNavigationButton),
                                      height: CGFloat( integerLiteral: .heightNavigationButton))
                button.layer.cornerRadius = CGFloat(.widthNavigationButton/2)
                button.setImage(UIImage(systemName: .imageButtonMenu), for: [])
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



