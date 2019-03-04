//
//  UIViewController+Rx.swift
//  MovieDbExplorer
//
//  Created by Kamil Kowalski on 03/03/2019.
//  Copyright © 2019 Kamil Kowalski. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear(_:))).map { _ in }
        return ControlEvent(events: source)
    }
}
