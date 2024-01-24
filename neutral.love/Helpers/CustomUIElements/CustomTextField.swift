//
//  AuthTextField.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 27.10.2023.
//

import UIKit

final class CustomTextField: UITextField {

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(placeholder: String) {
        self.init(frame: .zero)

        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.label]
        let placeholderText = NSAttributedString(
            string: placeholder,
            attributes: attribute
        )
        attributedPlaceholder = placeholderText

        configureTextField()
    }

    private func configureTextField() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        leftView = UIView(
            frame: CGRect(
            x: 0,
            y: 0,
            width:
                8,
            height: 0
            )
        )
        leftViewMode = .always

        rightView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 8,
                height: 0
            )
        )
        rightViewMode = .always
        translatesAutoresizingMaskIntoConstraints = false
    }
}
