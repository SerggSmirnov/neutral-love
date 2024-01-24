//
//  GenerateTextField.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 22.10.2023.
//

import UIKit

final class GenerateTextField: UITextField {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppearance()
        setupResources()
        setupBehaviour()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.systemGray2]
        let placeholderText = NSAttributedString(
            string: placeholder,
            attributes: attribute
        )
        attributedPlaceholder = placeholderText
    }
}

// MARK: - Setup appearance

private extension GenerateTextField {
    func setupAppearance() {
        backgroundColor = Resources.Colors.GenerateModule.textFildBackgroundColor
        layer.cornerRadius = 15
        layer.masksToBounds = true
        font = Resources.Fonts.SFProTextSemibold35
        leftView = UIView(
            frame: CGRect(x: 0, y: 0, width: 20, height: 0)
        )
    }
}

// MARK: - Setup behaviour

private extension GenerateTextField {
    func setupBehaviour() {
        leftViewMode = .always
        clearButtonMode = .always
        returnKeyType = .done
        autocapitalizationType = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Setup resources

private extension GenerateTextField {
    func setupResources() {
        textColor = Resources.Colors.GenerateModule.textFildTextColor
    }
}
