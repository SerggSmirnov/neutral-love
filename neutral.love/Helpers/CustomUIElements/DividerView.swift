//
//  DividerView.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 27.11.2023.
//

import UIKit

final class DividerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDividerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureDividerView() {
        backgroundColor = .systemGray2.withAlphaComponent(0.4)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
