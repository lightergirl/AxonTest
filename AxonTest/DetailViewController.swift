//
//  DetailViewController.swift
//  AxonTest
//
//  Created by Evgeniya Ignatyeva on 5/16/19.
//  Copyright © 2019 Evgeniya Ignatyeva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailView: DetailView!
    var userInfo: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = userInfo else { return }
        detailView.avatarImageView.getImage(from: user.imageUrl)
        detailView.fullNameLabel.text = user.fullName
        detailView.genderLabel.text = user.gender
        detailView.dobLabel.text = user.dob
        detailView.phoneLabel.text = user.phone
        detailView.emailLabel.text = user.email
        detailView.cellLabel.text = user.cell
        detailView.cellButton.addTarget(self, action: #selector(showActionSheet(controller:)), for: .touchUpInside)
    }
    
    @objc func showActionSheet(controller: UIViewController) {
        let alert = UIAlertController(title: "Call", message: "Please Select the Number", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Phone", style: .default, handler: { (_) in
            self.makeCall(by: self.detailView.phoneLabel.text)
            print("User click Phone button")
        }))
        
        alert.addAction(UIAlertAction(title: "Cell", style: .default, handler: { (_) in
            self.makeCall(by: self.detailView.cellLabel.text)
            print("User click Cell button")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Cancel button")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func makeCall(by stringNumber: String?) {
        guard let phoneText = stringNumber else { return }
        let number = phoneText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard let numberUrl = URL(string: "tel://\(number)") else { return }
        UIApplication.shared.open(numberUrl, options: [:], completionHandler: nil)
    }
}
