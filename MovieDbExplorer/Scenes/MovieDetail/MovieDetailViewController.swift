//
//  MovieDetailViewController.swift
//  MovieDbExplorer
//
//  Created by Kamil Kowalski on 03/03/2019.
//  Copyright © 2019 Kamil Kowalski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Nuke

final class MovieDetailViewController: UIViewController {
    var viewModel: MovieDetailViewModel!
    
    @IBOutlet weak var headerView: MovieDetailHeaderView!
    @IBOutlet weak var tipsView: MovieDetailTipsView!
    @IBOutlet weak var posterImageView: GradientImageView!
    @IBOutlet weak var backButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func bindViewModel() {
        let input = MovieDetailViewModel.Input(ready: rx.viewWillAppear.asDriver(),
                                               backTrigger: backButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.data
            .drive(onNext: { [weak self] data in
                guard let data = data,
                    let strongSelf = self else { return }
                strongSelf.headerView.configure(with: data)
                strongSelf.tipsView.configure(with: data)
                if let url = data.posterUrl {
                    Nuke.loadImage(with: URL(string: url)!, into: strongSelf.posterImageView)
                }
            })
            .disposed(by: disposeBag)
        
        output.back
            .drive()
            .disposed(by: disposeBag)
    }
}
