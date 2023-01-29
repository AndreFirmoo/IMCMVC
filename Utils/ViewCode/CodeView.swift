//
//  CodeView.swift
//  IMC
//
//  Created by Andre Firmo on 22/01/23.
//

import Foundation
protocol CodeView {
    func setupView()
    func setupComponents()
    func setupConstraints()
}
extension CodeView {
    func setupView() {
        setupComponents()
        setupConstraints()
    }
}
