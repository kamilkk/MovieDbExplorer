//
//  SearchViewController.swift
//  MovieDbExplorer
//
//  Created by Kamil Kowalski on 03/03/2019.
//  Copyright © 2019 Kamil Kowalski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    var viewModel: SearchViewModel!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: String(describing: SearchCell.self), bundle: nil),
                               forCellReuseIdentifier: String(describing: SearchCell.self))
        }
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func bindViewModel() {
        let input = SearchViewModel.Input(searchText: searchTextField.rx.text.orEmpty.asDriver(),
                                          selectedCategoryIndex: segmentedControl.rx.value.asDriver(),
                                          selected: tableView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.switchHidden
            .drive(segmentedControl.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        
        output.results
            .drive(tableView.rx.items(cellIdentifier: String(describing: SearchCell.self), cellType: SearchCell.self)) { (row, element, cell) in
                cell.configure(withSearchResultItemViewModel: element)
            }
            .disposed(by: disposeBag)
        
        output.selectedDone
            .drive()
            .disposed(by: disposeBag)
    }
}
