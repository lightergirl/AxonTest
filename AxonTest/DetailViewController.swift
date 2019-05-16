//
//  DetailViewController.swift
//  AxonTest
//
//  Created by Evgeniya Ignatyeva on 5/16/19.
//  Copyright © 2019 Evgeniya Ignatyeva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var userInfo: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = userInfo, let detailView = self.view as? DetailView else { return }
        detailView.avatarImageView.getImage(from: user.imageUrl)
        detailView.fullNameLabel.text = user.fullName
        detailView.genderLabel.text = user.gender
        detailView.dobLabel.text = user.dob
        detailView.phoneLabel.text = user.phone
        detailView.emailLabel.text = user.email
        detailView.cellLabel.text = user.cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
