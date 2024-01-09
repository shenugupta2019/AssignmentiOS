//
//  ViewController.swift
//  MVVMRxSwiftProject
//
//  Created by Shenu Gupta on 09/01/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let vm = ViewModel()
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        bindTableView()
        // Do any additional setup after loading the view.
        addObservers()
    }
    private func bindTableView() {
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        
        vm.rows.bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: ListTableViewCell.self)) { (row,item,cell) in
            cell.item = item
        }.disposed(by: bag)
        
    
    }
}

extension ViewController {
    private func addObservers() {
    
//        vm.breweries.bind(to: tableView.rx.items) { (tableView, row, brewery) -> UITableViewCell in
//            let cell = tableView
//                .dequeueReusableCell(withIdentifier: BreweryTableViewCell.id,
//                                     for: IndexPath(row: row, section: 0)) as! BreweryTableViewCell
//            cell.setupCell(with: brewery)
//
//            return cell
//        }.disposed(by: bag)
      
        
        vm.rows.subscribe { [self] _ in
            DispatchQueue.main.async {
                print("shenu data fetched")
//                emptyLabel.isHidden = vm.breweries.value.count != 0
            }
        }.disposed(by: bag)
        
        fetchBreweries()
        
      
        
      
    }
    
    private func fetchBreweries() {
       // activityIndicator.startAnimating()
        vm.getBreweries(completion: {  (success, message) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) {
               // activityIndicator.stopAnimating()
            }
            
            if success {
               // print(vm.selectedBreweryType.value)
            } else {
                print(message ?? "Failed")
            }
        })
    }
    
    private func setupUI() {
    }
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}

