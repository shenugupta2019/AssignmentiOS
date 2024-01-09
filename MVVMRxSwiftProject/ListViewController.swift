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
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        
        vm.rows.bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: ListTableViewCell.self)) { (row,item,cell) in
            cell.item = item
        }.disposed(by: bag)
    }
}

extension ViewController {
    private func addObservers() {
        vm.rows.subscribe { [self] _ in
            DispatchQueue.main.async {
                print("data fetched")
            }
        }.disposed(by: bag)
        
        fetchData()
    }
    
    private func fetchData() {
       // activityIndicator.startAnimating()
        vm.getData(completion: {  (success, message) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) {
            }
            
            if success {
               // print(vm.selectedBreweryType.value)
            } else {
                print(message ?? "Failed")
            }
        })
    }
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

