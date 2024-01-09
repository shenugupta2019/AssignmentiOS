//
//  ListViewModel.swift
//  ListTableViewCell.swift
//  MVVMRxSwiftProject
//
//  Created by Shenu Gupta on 09/01/24.
//

import UIKit
import RxCocoa
import RxSwift
import Action
import APIKit

class ViewModel {
    let session = URLSession.shared
 
    var rows = BehaviorRelay<[rows]>(value: [])
    
    func getData(completion: @escaping (_ status: Bool, _ message: String?) -> Void) {
        
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
