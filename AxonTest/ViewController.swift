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
                guard let responseData = try? decoder.decode(RandomUserResponse.self, from: responseObject) else {
                    let responseError = try? decoder.decode(String.self, from: responseObject)
                    // present error popup
                }
//                self.prepareViewModel(responseData.response)
                self.page += 1
            } catch {
                print("Decoding response error: \(error)")
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
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
