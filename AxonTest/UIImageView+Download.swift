//
//  UIImageView+Download.swift
//  AxonTest
//
//  Created by Evgeniya Ignatyeva on 5/16/19.
//  Copyright © 2019 Evgeniya Ignatyeva. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func getImage(from stringUrl: String) {
        guard let imageURL = URL(string: stringUrl) else { return }
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
                print("Did download image data from \(stringUrl)")
            }
        }
    }
}
