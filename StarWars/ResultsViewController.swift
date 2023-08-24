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
    override func viewDidLayoutSubviews() {
        backgroundImage.frame = CGRect(x: view.frame.origin.x,
                                  y: view.frame.origin.y,
                                  width: view.bounds.size.width ,
                                  height: view.bounds.size.height)
    }
    
//MARK: - flow funcs
    private func settingResultView() {
        settingBackgroundView()
        settingButtons(for: [closeViewButton])
        settingTableView()
    }
    
    private func settingTableView() {
        tableViewResults = UITableView(frame: CGRect(x:view.frame.origin.x + CGFloat( integerLiteral: .universalConstraint),
                                                     y: view.frame.origin.y + closeViewButton.frame.maxY + CGFloat( integerLiteral: .universalConstraint),
                                                     width: view.frame.width - 2*CGFloat( integerLiteral: .universalConstraint),
                                                     height: view.frame.height - CGFloat( integerLiteral: .universalConstraint) - closeViewButton.frame.maxY))
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
extension ResultsViewController: ViewProtocol {
    func settingBackgroundView() {
        let image = UIImageView(image: UIImage(named: .imageBackground))
        backgroundImage = image.layer
        view.layer.insertSublayer(backgroundImage, at: 0)
    }
    
    func settingButtons(for buttons: [UIButton]) {
        _ = buttons.map { button in
            button.layer.cornerRadius = CGFloat(integerLiteral: .cornerRadiusCell)
            button.layer.borderWidth = CGFloat(integerLiteral: .borderWidthCell)
            button.layer.borderColor = UIColor.systemGray.cgColor
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
            default:
                print("ups: Button")
            }
        }
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let results = ResultsGame.getResults()
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .identifireCellResults, for: indexPath) as? ResultsTableViewCell
        cell?.settingCellResultsTable(indexPath: indexPath)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(integerLiteral: .heightCell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
