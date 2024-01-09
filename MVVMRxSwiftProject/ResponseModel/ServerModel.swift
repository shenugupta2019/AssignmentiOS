//
//  ServerModel.swift
//  MVVMRxSwiftProject
//
//  Created by Shenu Gupta on 09/01/24.
//


import Foundation

struct  ServerRequestModel: Decodable {
    let rows: [rows]
  
}

struct rows: Decodable{
    var title: String?
    var description: String?
    var imageHref:String?
    
    enum CodingKeys: String, CodingKey { // Our Saviour
            case title = "title"
            case description = "description"
            case imageHref = "imageHref"
        }
        
        // The Initializer function from Decodable
        init(from decoder: Decoder) throws {
            // 1 - Container
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
     
        if let title =  try? values.decodeIfPresent(String.self, forKey: .title) {
                self.title = title
            }else {
                self.title = "N/A"
            }
         
            // 3 - Conditional Decoding
            if let description =  try? values.decodeIfPresent(String.self, forKey: .description) {
                self.description = description
            }else {
                self.description = "N/A"
            }
            
            if let imageHref =  try? values.decodeIfPresent(String.self, forKey: .imageHref) {
                self.imageHref = imageHref
            }else {
                self.imageHref = "N/A"
            }
           
        }
    
}

