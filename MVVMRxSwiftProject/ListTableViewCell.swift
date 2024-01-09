//
//  ProductTableViewCell.swift
//  RxTableViewOne
//
//  Created by Mahdi Mahjoobe on 12/10/18.
//  Copyright © 2018 Mahdi Mahjoobe. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        holderView.layer.cornerRadius = 10
        productImg.layer.cornerRadius = productImg.frame.width / 2
        productImg.clipsToBounds = true
    }
    
    var item: rows! {
        didSet {
            setProductData()
        }
    }

    private func setProductData() {
        let url = URL(string: item.imageHref!)!
        downloadImage(from:url)
        nameLbl.text = item.title
        priceLbl.text = item.description
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            if error != nil {
                DispatchQueue.main.async() {
                    self.productImg.image = UIImage(named: "iphone")
                }
            }
            else {
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                // always update the UI from the main thread
                DispatchQueue.main.async() {
                    self.productImg.image = UIImage(data: data ?? Data())
                    
                }
            }
        }
    }

}

struct Product {
    let imageName, name, price: String
}

