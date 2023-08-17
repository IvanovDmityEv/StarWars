//
//  ResultsViewController.swift
//  StarWars
//
//  Created by Dmitriy on 02.08.2023.
//

import UIKit

class ResultsViewController: UIViewController {
    
//MARK: - vars/lets
    var backgroundImage = CALayer()
    let closeViewButton = UIButton(type: .system)
    var tableViewResults = UITableView()
    
    
//MARK: - lifecycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        settingResultView()
    }

    
//MARK: - flow funcs
    private func settingResultView() {
        settingBackgroundView()
        settingButtons(for: [closeViewButton])
        settingTableView()
    }
    
    private func settingTableView() {
        tableViewResults = UITableView(frame: CGRect(x:view.frame.origin.x + CGFloat(integerLiteral: .buttomConstraint),
                                                     y: view.frame.origin.y + closeViewButton.frame.maxY + CGFloat(integerLiteral: .buttomConstraint),
                                                     width: view.frame.width - 2*CGFloat(integerLiteral: .buttomConstraint),
                                                     height: view.frame.height - CGFloat(integerLiteral: .buttomConstraint)))
        view.layer.insertSublayer(tableViewResults.layer, at: 1)
        tableViewResults.backgroundColor = .clear
        tableViewResults.delegate = self
        tableViewResults.dataSource = self
        tableViewResults.register(ResultsTableViewCell.self, forCellReuseIdentifier: .identifireCellResults)
        
    }
    
    
//MARK: - IBActions
    @IBAction func closeView(_ closeViewButton: UIButton) {
       dismiss(animated: true)
    }
}
//MARK: - extensions
extension ResultsViewController: SettingViewProtocol {
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

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .identifireCellResults, for: indexPath) as! ResultsTableViewCell
        cell.settingCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(integerLiteral: .heightCloseWiewButton)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}







extension Int {
    static let widthCloseWiewButton = 40
    static let heightCloseWiewButton = 40
}
extension String {
    static let imageMenu = "line.horizontal.3.decrease"
    static let identifireCellResults = "CellResults"
    
}
