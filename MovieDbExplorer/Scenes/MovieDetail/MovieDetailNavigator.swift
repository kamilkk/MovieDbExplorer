//
//  MovieDetailNavigator.swift
//  MovieDbExplorer
//
//  Created by Kamil Kowalski on 03/03/2019.
//  Copyright © 2019 Kamil Kowalski. All rights reserved.
//

import UIKit

protocol MovieDetailNavigatable {
    func goBack()
}

final class MovieDetailNavigator: MovieDetailNavigatable {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
