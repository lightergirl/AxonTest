//
//  ViewController.swift
//  AxonTest
//
//  Created by Evgeniya Ignatyeva on 5/15/19.
//  Copyright © 2019 Evgeniya Ignatyeva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let apiManager = APIManager()
    var users: [User] = []
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSearch()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }

    func performSearch() {
        apiManager.request(.get(users: 20, from: page)) { responseObject, error in
            guard let responseObject = responseObject, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let responseData = try decoder.decode(ResponseEnum.self, from: responseObject)
                switch responseData {
                case .error(let err):
                    print(err)
                    // server error popup?
                    return
                case .data(let data):
                    self.prepareViewModel(data.results)
                    self.page += 1
                }
            } catch {
                print("Decoding response error: \(error)")
            }
        }
    }
    
    func prepareViewModel(_ response: [Result]) {
        if response.isEmpty{
            DispatchQueue.main.async {
                self.tableView.isHidden = true
            }
        }
        for item in response {
            let user = User.init(with: item)
            users.append(user)
        }
        NotificationCenter.default.post(name: .didReceiveData, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailViewController, let info = sender as? User {
            vc.userInfo = info
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.avatarView.getImage(from: users[indexPath.row].smallImageUrl)
        cell.nameLabel.text = users[indexPath.row].fullName
        cell.ageLabel.text = users[indexPath.row].age
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetails = users[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: userDetails)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell)  {
            performSearch()
        }
    }
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= users.count - 1
    }
}
