//
//  UIImageExtension.swift
//  ChuckApi
//
//  Created by jonnattan Choque on 23/11/21.
//

import Foundation
import UIKit

extension UIImageView {

    func load(urlSting: String) {
        let http = URL(string: urlSting)!
        var comps = URLComponents(url: http, resolvingAgainstBaseURL: false)!
        comps.scheme = "https"
        let urlImage = comps.url!
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: urlImage) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
