//
//  ChuckModel.swift
//  ChuckApi
//
//  Created by jonnattan Choque on 23/11/21.
//

import Foundation


class ChuckModel: Codable{
    var id : String
    var icon_url: String
    var value : String
    
    init(id: String, icon_url: String, value: String){
        self.id = id
        self.icon_url = icon_url
        self.value = value
    }
}
