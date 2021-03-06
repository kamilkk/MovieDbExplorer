//
//  DiscoverViewController.swift
//  MovieDbExplorer
//
//  Created by Kamil Kowalski on 03/03/2019.
//  Copyright © 2019 Kamil Kowalski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DiscoverViewController: BaseViewController {
    var viewModel: DiscoverViewModel!
    
    @IBOutlet weak var carouselsView: DiscoverMainView!
    
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func bindViewModel() {
        let input = DiscoverViewModel.Input(ready: rx.viewWillAppear.asDriver(),
                                            selected: carouselsView.selectedIndex.asDriver(onErrorJustReturn: (0, 0)))
        
        let output = viewModel.transform(input: input)
        
        output.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        output.results
            .drive(onNext: { [weak self] caroselViewModel in
                guard let strongSelf = self else { return }
                strongSelf.carouselsView.setDataSource(caroselViewModel)
                strongSelf.carouselsView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.selected
            .drive()
            .disposed(by: disposeBag)
    }
}
