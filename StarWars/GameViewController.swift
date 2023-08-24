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
    let closeViewButton = UIButton(type: .system)
    
    var layerRebelStarship = CALayer()
    var layerEmpireStarship: CALayer?
    var layerBulletRebelStarship: CALayer?
    var layerBulletEmpireStarship: CALayer?
    
    var layersEmpireStarships: [CALayer] = []
    var layersBullestRebelStarship: [CALayer] = []
    
    var timer = Timer()
    let gameScore = UILabel()
    var gamePoints: Int = 0 {
        didSet {
            gameScore.text = String(gamePoints)
        }
    }
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
        guard let layerRebelStarship = createStarhip(name: .rebelStarship) else { return }
        view.layer.insertSublayer(layerRebelStarship, at: 1)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
                }
            guard let layerEmpireStarship = self.createStarhip(name: .empireStarship) else { return }
                self.view.layer.insertSublayer(layerEmpireStarship, at: 2)
                self.layersEmpireStarships.append(layerEmpireStarship)
                self.moveEmpireStarship(layerEmpireStarship)
//                self.fire(for: .empireStarship)
        }
    }
    
    private func createStarhip(name: String) -> CALayer? {
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
            layerEmpireStarship = CALayer()
            layerEmpireStarship = imageEmpireStarship.layer
            layerEmpireStarship?.frame = CGRect(x: randomX,
                                                y: Int(view.frame.minY),
                                                width: Int(view.frame.width) / .countCell,
                                                height: Int(view.frame.width) / .countCell)
            imageEmpireStarship.image = UIImage(named: randomStarsip)
            return layerEmpireStarship
            
        case .rebelStarship:
            let imageRebelStarship = UIImageView()
            layerRebelStarship = imageRebelStarship.layer
            let positionY = view.frame.maxY - leftClickButton.frame.height - CGFloat(integerLiteral: .universalConstraint) - CGFloat(widthStarship)
            layerRebelStarship.frame = CGRect(x: Int(view.frame.maxX/2) - widthStarship/2,
                                              y: Int(positionY),
                                              width: Int(view.frame.width) / .countCell,
                                              height: Int(view.frame.width) / .countCell)
            let namesRebelStarships: [String] = [.imageXWing, .imageMilleniumFalcon, .imageRebellionShip]
            let selectedRebelStarship = namesRebelStarships[settings.indexStarship ?? 0]
            imageRebelStarship.image = UIImage(named: selectedRebelStarship)
            return layerRebelStarship
            default:
                print("ups: AddStarship")
        }
        return nil
    }
    
    private func moveEmpireStarship(_ layerEmpireStarship: CALayer) {
        let empireStarshipAnimation = CABasicAnimation(keyPath: "position.y")
        empireStarshipAnimation.fromValue = layerEmpireStarship.position.y
        empireStarshipAnimation.toValue = view.bounds.height + layerEmpireStarship.frame.height*2
        empireStarshipAnimation.duration = setSpeadgame()
        empireStarshipAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        layerEmpireStarship.add(empireStarshipAnimation, forKey: "empireStarshipAnimation")
    
        let collisionDetection = CADisplayLink(target: self, selector: #selector(checkCollision))
        collisionDetection.add(to: .main, forMode: .common)
    }
    
    private func setSpeadgame() -> CFTimeInterval {
        let speedGame = settings.speedGame
        switch speedGame{
        case 1:
            return 5
        case 2:
            return 4
        case 3:
            return 3
        case .none:
            return 3
        case .some(_):
            return 3
        }
    }
    
    @objc func checkCollision() {
        let stopMaxYFrame = CGRect(x: view.frame.minX, y: view.frame.maxY + layerRebelStarship.frame.height, width: view.frame.width, height: .zero)
        let stopMinYFrame = CGRect(x: view.frame.minX, y: view.frame.minY - layerRebelStarship.frame.height, width: view.frame.width, height: .zero)
        let rebelStarshipFrame = layerRebelStarship.presentation()?.frame ?? .zero
        for i in 0..<layersEmpireStarships.count {
            let starship = layersEmpireStarships[i].presentation()?.frame ?? .zero
            if starship.intersects(rebelStarshipFrame) {
                timer.invalidate()
                layersEmpireStarships[i].removeAllAnimations()
                layersEmpireStarships[i].removeFromSuperlayer()
                layerRebelStarship.removeFromSuperlayer()
                layersEmpireStarships.remove(at: i)
                showAlert()
                break
            }
            for j in 0..<layersBullestRebelStarship.count {
                let bullet = layersBullestRebelStarship[j].presentation()?.frame ?? .zero
                if bullet.intersects(starship) {
                    layersEmpireStarships[i].removeAllAnimations()
                    layersEmpireStarships[i].removeFromSuperlayer()
                    layersBullestRebelStarship[j].removeAllAnimations()
                    layersBullestRebelStarship[j].removeFromSuperlayer()
                    layersBullestRebelStarship.remove(at: j)
                    gamePoints += .points
                    break
                }
                if bullet.intersects(stopMinYFrame) {
                    layersBullestRebelStarship[j].removeAllAnimations()
                    layersBullestRebelStarship[j].removeFromSuperlayer()
                    layersBullestRebelStarship.remove(at: j)
                    break
                }
            }
            if starship.intersects(stopMaxYFrame) {
                layersEmpireStarships[i].removeAllAnimations()
                layersEmpireStarships[i].removeFromSuperlayer()
                layersEmpireStarships.remove(at: i)
                break
            }
        }
    }
    
    private func saveResult() {
        if gamePoints > 0 {
            let resultPlayer = ResultPlayer(name: settings.namePlayer ?? .imageXWing,
                                      starship: settings.nameStarship ?? .imageXWing,
                                      gamePoints: gamePoints)
            ResultsGame.saveResult(resultPlayer)
        }
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: .titleAlert,
                                                message: .messageAlert,
                                                preferredStyle: .alert)
        alertController.view.tintColor = .black
        
        let actionRestart = UIAlertAction(title: .buttonAlertRestart,
                                          style: .default) { [weak self] _ in
            self?.saveResult()
            self?.gamePoints = 0
            self?.addStarships()
        }
        let actionGoMenu = UIAlertAction(title: .buttonAlertGoToMenu,
                                         style: .default) { [weak self] _ in
            self?.saveResult()
            self?.dismiss(animated: true)
        }
        alertController.addAction(actionRestart)
        alertController.addAction(actionGoMenu)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func moveRebelStarship(for button: UIButton) {
        let distance = Int(layerRebelStarship.frame.size.width)
            switch button {
            case self.leftClickButton:
                UIView.animate(withDuration: .withDurationRebelStarship) {
                    if self.layerRebelStarship.frame.origin.x - CGFloat(distance) >= self.view.frame.minX {
                        self.layerRebelStarship.frame.origin.x -= CGFloat(distance)
                    } else {
                        return
                    }
                }
            case self.rightClickButton:
                UIView.animate(withDuration: .withDurationRebelStarship) {
                    if self.layerRebelStarship.frame.origin.x + CGFloat(distance) <= self.view.frame.maxX - CGFloat(distance) {
                        self.layerRebelStarship.frame.origin.x += CGFloat(distance)
                    } else {
                        return
                    }
                }
            default:
                print("ups: moveRebelStarship")
            }
    }
    
    private func fire(for starship: String) {
        switch starship {
        case .rebelStarship:
            guard let bulletForRebelStarship = createBullet(for: layerRebelStarship) else { return }
            layersBullestRebelStarship.append(bulletForRebelStarship)
            muveBullet(bullet: bulletForRebelStarship, for: starship)
        case .empireStarship: break
//            guard let bulletForEmpireStarship = createBullet(for: layerEmpireStarship ?? CALayer()) else { return }
//            muveBullet(bullet: bulletForEmpireStarship, for: starship)
        default:
            print("ups: fire")
        }
    }
    
    private func createBullet(for starship: CALayer) -> CALayer? {
        let widthBullet: Int = .widthBullet
        switch starship {
        case layerRebelStarship:
            layerBulletRebelStarship = CALayer()
            layerBulletRebelStarship?.cornerRadius = CGFloat(integerLiteral: .widthBullet)/2
            self.view.layer.insertSublayer(layerBulletRebelStarship ?? CALayer(), at: 3)
            layerBulletRebelStarship?.backgroundColor = UIColor.systemYellow.cgColor
            layerBulletRebelStarship?.frame = CGRect(x: Int(layerRebelStarship.frame.midX) - widthBullet/2,
                                       y: Int(layerRebelStarship.frame.origin.y) - widthBullet/2,
                                       width:  widthBullet,
                                       height: widthBullet)
            return layerBulletRebelStarship
            
        case layerEmpireStarship: break
//            layerBulletEmpireStarship = CALayer()
//            layerBulletEmpireStarship?.cornerRadius = CGFloat(integerLiteral: .widthBullet)/2
//            self.view.layer.insertSublayer(layerBulletEmpireStarship ?? CALayer(), at: 3)
//            layerBulletEmpireStarship?.backgroundColor = UIColor.systemRed.cgColor
//            guard let layerEmpireStarship = layerEmpireStarship else { return nil}
//            layerBulletEmpireStarship?.frame = CGRect(x: Int(layerEmpireStarship.frame.midX) - widthBullet/2,
//                                                      y: Int(layerEmpireStarship.frame.origin.y + layerEmpireStarship.frame.height) + widthBullet/2,
//                                                      width:  widthBullet,
//                                                      height: widthBullet)
//            return layerBulletEmpireStarship
        default:
            print("ups: createBullet")
        }
        return nil
    }
    
    private func muveBullet(bullet: CALayer, for starship: String) {
        switch starship {
        case .rebelStarship:
            let bulletRebelStarshipAnimation = CABasicAnimation(keyPath: "position.y")
            bulletRebelStarshipAnimation.fromValue = bullet.position.y
            bulletRebelStarshipAnimation.toValue = view.frame.origin.y - 2*layerRebelStarship.frame.height
            bulletRebelStarshipAnimation.duration = 2
            bulletRebelStarshipAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
            bulletRebelStarshipAnimation.isRemovedOnCompletion = true
            bullet.add(bulletRebelStarshipAnimation, forKey: "bulletRebelStarshipAnimation")
            
        case .empireStarship:
            let bulletEmpireStarshipAnimation = CABasicAnimation(keyPath: "position.y")
            bulletEmpireStarshipAnimation.fromValue = bullet.position.y
            bulletEmpireStarshipAnimation.toValue = view.frame.maxY + 2*layerRebelStarship.frame.height
            bulletEmpireStarshipAnimation.duration = 2
            bulletEmpireStarshipAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
            bulletEmpireStarshipAnimation.isRemovedOnCompletion = true
            bullet.add(bulletEmpireStarshipAnimation, forKey: "bulletEmpireStarshipAnimation")
        default:
            print("ups: muveBullet")
        }
        let collisionDetection = CADisplayLink(target: self, selector: #selector(checkCollision))
        collisionDetection.add(to: .main, forMode: .common)
    }
    
//MARK: - IBActions
    @IBAction func goToLeft(_ leftClickButton: UIButton) {
        moveRebelStarship(for: leftClickButton)
    }
    @IBAction func goToRight(_ rightClickButton: UIButton) {
        moveRebelStarship(for: rightClickButton)
    }
    @IBAction func closeView(_ closeViewButton: UIButton) {
        saveResult()
        dismiss(animated: true)
    }
    @IBAction func fire(_ fireButton: UIButton) {
        fire(for: .rebelStarship)
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
