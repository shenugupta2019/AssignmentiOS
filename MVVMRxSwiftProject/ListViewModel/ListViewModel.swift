//
//  ListViewModel.swift
//  RxSwiftMVVM
//
//  Created by Tsubasa Hayashi on 2019/04/29.
//  Copyright © 2019 Tsubasa Hayashi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Action
import APIKit

class ViewModel {
    let session = URLSession.shared
 
    var rows = BehaviorRelay<[rows]>(value: [])
    
    func getBreweries(completion: @escaping (_ status: Bool, _ message: String?) -> Void) {
        
       // guard let url = getUrl("") else { return }
        
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        
        let task = session.dataTask(with: url) { [self] (data, response, error) in
            
            if error != nil {
                completion(false, error?.localizedDescription)
            }
            
            do {
                let utf8Data = String(decoding: data!, as: UTF8.self).data(using: .utf8)

                let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(ServerRequestModel.self, from: utf8Data!)

               
                rows.accept(result.rows ?? [])
                
                completion(true, "Success")
            } catch {
                completion(false, error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    private func getUrl(_ type: String) -> URL? {
        return URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
    }
}
