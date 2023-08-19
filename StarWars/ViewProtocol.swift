//
//  SettingViewProtocol.swift
//  StarWars
//
//  Created by Dmitriy on 02.08.2023.
//

import Foundation
import UIKit

protocol ViewProtocol: AnyObject {
    func settingBackgroundView()
    func settingButtons(for buttons: [UIButton])
}
