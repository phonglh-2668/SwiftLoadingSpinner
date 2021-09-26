//
//  ViewController.swift
//  SwiftLoadingSpinner
//
//  Created by phonglh-2668 on 09/25/2021.
//  Copyright (c) 2021 phonglh-2668. All rights reserved.
//

import UIKit
import SwiftLoadingSpinner

class ViewController: UIViewController {
    
    private let loading: SwiftLoadingSpinner = {
        let loading = SwiftLoadingSpinner(icon: .square,
                                          animation: .spiral)
        return loading
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loading)
        view.backgroundColor = .orange
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.heightAnchor.constraint(equalToConstant: 42),
            loading.widthAnchor.constraint(equalToConstant: 42),
        ])
    }
}
