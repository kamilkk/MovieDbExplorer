//
//  LoginViewController.swift
//  MovieDbExplorer
//
//  Created by Kamil Kowalski on 03/03/2019.
//  Copyright © 2019 Kamil Kowalski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: BaseViewController {
    var viewModel: LoginViewModel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func bindViewModel() {
        let input = LoginViewModel.Input(
            username: usernameTextField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver(),
            loginTaps: loginButton.rx.tap.asSignal()
        )
        
        let output = viewModel.transform(input: input)
        
        output.enabled
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.enabled
            .drive(onNext: { [weak self] enabled in
                guard let strongSelf = self else { return }
                strongSelf.loginButton.backgroundColor = enabled ?
                    UiHelpers.appColor() :
                    UIColor.lightGray
            })
            .disposed(by: disposeBag)
        
        output.loading
            .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        output.result
            .filter { $0 == LoginResult.failure }
            .drive(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                let alert = UIAlertController(title: "Oops!", message: "Login failed", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                strongSelf.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
