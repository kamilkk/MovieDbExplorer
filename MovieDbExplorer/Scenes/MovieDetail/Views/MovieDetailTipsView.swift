//
//  MovieDetailTipsView.swift
//  MovieDbExplorer
//
//  Created by Kamil Kowalski on 03/03/2019.
//  Copyright © 2019 Kamil Kowalski. All rights reserved.
//

import UIKit

final class MovieDetailTipsView: UIView {
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func configure(withVoteCount voteCount: String,
                   status: String) {
        self.voteCountLabel.text = voteCount
        self.statusLabel.text = status
    }
    
    private func setup() {
        Bundle.main.loadNibNamed("MovieDetailTipsView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
}

extension MovieDetailTipsView {
    func configure(with data: MovieDetailData) {
        configure(withVoteCount: data.voteCount,
                  status: data.status)
    }
}
