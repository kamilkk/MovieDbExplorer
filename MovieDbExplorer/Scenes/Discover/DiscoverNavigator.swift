//
//  DiscoverNavigator.swift
//  MovieDbExplorer
//
//  Created by Kamil Kowalski on 03/03/2019.
//  Copyright © 2019 Kamil Kowalski. All rights reserved.
//

import UIKit

protocol DiscoverNavigatable {
    func navigateToMovieDetailScreen(withMovieId id: Int, api: MovieDbApiProvider)
    func navigateToPersonDetailScreen()
    func navigateToShowDetailScreen()
}

final class DiscoverNavigator: DiscoverNavigatable {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToMovieDetailScreen(withMovieId id: Int, api: MovieDbApiProvider) {
        let movieDetailNavigator = MovieDetailNavigator(navigationController: navigationController)
        let movieDetailViewModel = MovieDetailViewModel(dependencies: MovieDetailViewModel.Dependencies(id: id,
                                                                                                        api: api,
                                                                                                        navigator: movieDetailNavigator))
        let movieDetailViewController = UIStoryboard.main.movieDetailViewController
        movieDetailViewController.viewModel = movieDetailViewModel
        
        navigationController.show(movieDetailViewController, sender: nil)
    }
    
    func navigateToPersonDetailScreen() {
        
    }
    
    func navigateToShowDetailScreen() {
        
    }
}
