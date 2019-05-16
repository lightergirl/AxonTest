//
//  DetailView.swift
//  AxonTest
//
//  Created by Evgeniya Ignatyeva on 5/16/19.
//  Copyright © 2019 Evgeniya Ignatyeva. All rights reserved.
//

import UIKit

class DetailView: UIView {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBAction func makeCall(_ sender: Any) {
        // add choice
        guard let phoneText = phoneLabel.text else { return }
        let number = phoneText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard let numberUrl = URL(string: "tel://\(number)") else { return }
        UIApplication.shared.open(numberUrl)

    }
}
