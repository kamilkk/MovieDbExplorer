//
//  BaseViewController.swift
//  MovieDbExplorer
//
//  Created by Kamil Kowalski on 03/04/2019.
//  Copyright © 2019 Kamil Kowalski. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    func bindViewModel() {
        assert(false, "This method must be overriden by the subclass")
    }
}
