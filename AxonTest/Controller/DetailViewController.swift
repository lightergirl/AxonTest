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
        detailView.dobLabel.text = "BirthDay: \(user.dob)"
        detailView.phoneLabel.text = "Phone: \(user.phone)"
        detailView.emailLabel.text = "E-mail: \(user.email)"
        detailView.cellLabel.text = "Cell: \(user.cell)"
        detailView.callButton.addTarget(self, action: #selector(showActionSheet(controller:)), for: .touchUpInside)
    }

    @objc func showActionSheet(controller: UIViewController) {
        guard let user = userInfo else { return }
        let alert = UIAlertController(title: "Call", message: "Please select the Number", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Phone", style: .default, handler: { (_) in
            self.makeCall(by: user.phone) }))
        alert.addAction(UIAlertAction(title: "Cell", style: .default, handler: { (_) in
            self.makeCall(by: user.cell) }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in }))
        self.present(alert, animated: true, completion: nil)
        //FIXME: http://openradar.appspot.com/49289931
    }
    
    private func makeCall(by number: String) {
        guard let numberUrl = URL(string: "tel://\(number)") else { return }
        UIApplication.shared.open(numberUrl, options: [:], completionHandler: nil)
    }
}
