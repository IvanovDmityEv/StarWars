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
    let imageRebelStarship = UIImageView()
//    let imageEmpireStarship = UIImageView()
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
        settingButtons(for: [leftClickButton, rightClickButton, closeViewButton])
        settingGameScore()
        addStarships()
    }
    
    private func settingGameScore() {
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
            let layerEmpireStarship = imageEmpireStarship.layer
            self.view.layer.insertSublayer(layerEmpireStarship, at: 2)
            self.moveEmpireStarship(imageEmpireStarship)
        }
    }
    
    private func moveEmpireStarship(_ imageEmpireStarship: UIImageView) {
        
        UIView.animate(withDuration: 3, delay: 0, options: .curveLinear) {
            imageEmpireStarship.frame.origin.y += self.imageRebelStarship.frame.origin.y + self.imageRebelStarship.frame.height
            
        } completion: {_ in

            if self.checkCollisionFrame(empireStarshipFrame: imageEmpireStarship.frame, rebelStarshipFrame: self.imageRebelStarship.frame) {
                self.imageRebelStarship.removeFromSuperview()
                self.showAlert()
            }
        imageEmpireStarship.removeFromSuperview()
        }
    }
    
    private func checkCollisionFrame(empireStarshipFrame: CGRect, rebelStarshipFrame: CGRect) -> Bool {
        return empireStarshipFrame.intersects(rebelStarshipFrame)
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

    private func createStarship(name: String) -> UIImageView? {
        let widthStarship = Int(view.frame.size.width) / .countCell
        var coordinatesX: [CGFloat] = []
        var startPositionX = (self.view.frame.width - CGFloat(widthStarship))/2
        let countCell: Int = .countCell
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
                                 positionY: Int(view.frame.maxY) - widthStarship * 2 - .buttomConstraint,
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
                print("ups: moveXwing")
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
}

//MARK: - extensions

extension SpaceViewController: SettingViewProtocol {
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
                
            case closeViewButton:
                button.frame = CGRect(x: view.frame.minX + CGFloat(integerLiteral: .buttomConstraint),
                                      y: view.frame.minY + CGFloat(integerLiteral: .heightCloseWiewButton) + CGFloat(integerLiteral: .buttomConstraint),
                                         width: CGFloat(integerLiteral: .widthCloseWiewButton),
                                         height: CGFloat(integerLiteral: .heightCloseWiewButton))
                button.layer.cornerRadius = CGFloat(.widthCloseWiewButton/2)
                button.setImage(UIImage(systemName: .imageMenu), for: [])
                button.addTarget(self, action: #selector(self.closeView(_:)), for: .touchUpInside)
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
    
    static let fontName = "Futura Bold"
    
    static let titleAlert = "Mission failed"
    static let messageAlert = "You were shot down by an imperial fighter"
    static let buttonAlertRestart = "Restart"
    static let buttonAlertGoToMenu = "Menu"
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

extension Double {
    
    static let alpha = 0.5
}


