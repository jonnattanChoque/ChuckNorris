//
//  AlamofireApi.swift
//  ChuckApi
//
//  Created by jonnattan Choque on 23/11/21.
//

import Foundation
import Alamofire

class AlamofireApi{
    func getChucks(){
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {return}
        
        Alamofire.request(url).responseJSON { response in
            switch response.result{
            case .success(let result):
                let results = result as? NSDictionary
                let jsonData = self.jsonToData(json: results as Any)
                let decoder = JSONDecoder()
                do {
                    let resultItem = try decoder.decode(ChuckModel.self, from: jsonData!)
                    let result:[String: ChuckModel] = ["result": resultItem]
                    
                    NotificationCenter.default.post(name:Notification.Name(rawValue:"successChuck"),object:nil,userInfo:result)
                } catch let error {
                    print(error.localizedDescription)
                    let result:[String: String] = ["error": "No hay resultados"]
                    NotificationCenter.default.post(name:Notification.Name(rawValue:"errorChuck"),object:nil,userInfo:result)
                }
            case .failure(let error):
                print(error.localizedDescription)
                let result:[String: String] = ["error": error.localizedDescription]
                NotificationCenter.default.post(name:Notification.Name(rawValue:"errorChuck"),object:nil,userInfo:result)
            }
        }
    }
    
    func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
}
