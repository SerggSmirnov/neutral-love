//
//  GenerateViewController.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 21.10.2023.
//

import UIKit

final class GenerateViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: MainViewModelProtocol
    
    private let backgroundViewHeader: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.backgroundHeader
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.GenerateModule.headerLabel
        label.font = Resources.Fonts.SFProTextSemibold35
        label.textColor = Resources.Colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let promptLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.GenerateModule.promptLabel
        label.font = Resources.Fonts.SFProTextSemibold17
        label.textColor = Resources.Colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let styleLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.GenerateModule.styleLabel
        label.font = Resources.Fonts.SFProTextSemibold17
        label.textColor = Resources.Colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let layoutLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.GenerateModule.layoutLabel
        label.font = Resources.Fonts.SFProTextSemibold17
        label.textColor = Resources.Colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.GenerateModule.amountLabel
        label.font = Resources.Fonts.SFProTextSemibold17
        label.textColor = Resources.Colors.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stylePikerView = UIPickerView()
    private let layoutPikerView = UIPickerView()
    private let amountPikerView = UIPickerView()
    
    private let promptTextField = GenerateTextField(placeholder: "Type a prompt")
    private let styleTextField = GenerateTextField(placeholder: "Choose a style")
    private let layoutTextField = GenerateTextField(placeholder: "Choose a layout")
    private let amountTextField = GenerateTextField(placeholder: "Choose an amount")
    
    private lazy var generateImageButton: UIButton = { // вынести в отдельную кнопку для майн и генерат вью контроллеров
        let button = UIButton(type: .system)
        button.backgroundColor = Resources.Colors.MainModule.generateButtonBackground
        button.layer.cornerRadius = 15
        button.setTitle("Generate image", for: .normal) // convinience init
        button.titleLabel?.font = Resources.Fonts.SFProTextSemibold17
        button.tintColor = Resources.Colors.white
        button.addTarget(self, action: #selector(generateImages), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    @objc private func generateImages() {
        viewModel.prompt = promptTextField.text ?? ""
        viewModel.style = viewModel.styleData[stylePikerView.selectedRow(inComponent: 0)]
        viewModel.layout = viewModel.layoutData[layoutPikerView.selectedRow(inComponent: 0)]
        viewModel.amount = viewModel.amountData[amountPikerView.selectedRow(inComponent: 0)]
        
        viewModel.fetchDataOutputs()
        viewModel.countdownForGeneratingImages()
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupViews()
        setupDelagates()
        setupConstraints()
    }
    
    private func configure() {
        view.backgroundColor = Resources.Colors.backgroundGray
    }
    
    private func setupViews() {
        [
            backgroundViewHeader,
            headerLabel,
            promptTextField,
            promptLabel,
            styleLabel,
            styleTextField,
            layoutLabel,
            layoutTextField,
            amountLabel,
            amountTextField,
            generateImageButton
        ].forEach { view.addSubview($0) }
        
        styleTextField.inputView = stylePikerView
        layoutTextField.inputView = layoutPikerView
        amountTextField.inputView = amountPikerView
    }
    
    private func setupDelagates() {
        promptTextField.delegate = self
        
        stylePikerView.delegate = self
        stylePikerView.dataSource = self
        
        layoutPikerView.delegate = self
        layoutPikerView.dataSource = self
        
        amountPikerView.delegate = self
        amountPikerView.dataSource = self
        
        stylePikerView.tag = 1
        layoutPikerView.tag = 2
        amountPikerView.tag = 3
    }
}

// MARK: - UIPickerViewDelegate

extension GenerateViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1: return viewModel.styleData[row]
        case 2: return viewModel.layoutData[row]
        case 3: return viewModel.amountData[row]
        default: return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1: styleTextField.text = viewModel.styleData[row]
        case 2: layoutTextField.text = viewModel.layoutData[row]
        case 3: amountTextField.text = viewModel.amountData[row]
        default: return
        }
        styleTextField.resignFirstResponder()
        layoutTextField.resignFirstResponder()
        amountTextField.resignFirstResponder()
    }
}

// MARK: - UIPickerViewDataSource

extension GenerateViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1: return viewModel.styleData.count
        case 2: return viewModel.layoutData.count
        case 3: return viewModel.amountData.count
        default: return 1
        }
    }
}

// MARK: - UITextFieldDelegate

extension GenerateViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        promptTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Setup Constraints

private extension GenerateViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundViewHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundViewHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundViewHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundViewHeader.heightAnchor.constraint(equalToConstant: 68),
            
            headerLabel.centerYAnchor.constraint(equalTo: backgroundViewHeader.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            
            promptLabel.topAnchor.constraint(equalTo: backgroundViewHeader.bottomAnchor, constant: 30),
            promptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.labelsLead),
            
            promptTextField.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: Constants.textFieldsTop),
            promptTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            promptTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            promptTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldsHeight),
            
            styleLabel.topAnchor.constraint(equalTo: promptTextField.bottomAnchor, constant: Constants.labelsTop),
            styleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.labelsLead),
            
            styleTextField.topAnchor.constraint(equalTo: styleLabel.bottomAnchor, constant: Constants.textFieldsTop),
            styleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            styleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            styleTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldsHeight),
            
            layoutLabel.topAnchor.constraint(equalTo: styleTextField.bottomAnchor, constant: Constants.labelsTop),
            layoutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.labelsLead),
            
            layoutTextField.topAnchor.constraint(equalTo: layoutLabel.bottomAnchor, constant: Constants.textFieldsTop),
            layoutTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            layoutTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            layoutTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldsHeight),
            
            amountLabel.topAnchor.constraint(equalTo: layoutTextField.bottomAnchor, constant: Constants.labelsTop),
            amountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.labelsLead),
            
            amountTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: Constants.textFieldsTop),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
            amountTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldsHeight),
            
            generateImageButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 40),
            generateImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generateImageButton.heightAnchor.constraint(equalToConstant: 50),
            generateImageButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

// MARK: - Constants

extension GenerateViewController {
    
    private enum Constants {
        static let spacing: CGFloat = 20
        static let textFieldsHeight: CGFloat = 70
        static let labelsTop: CGFloat = 15
        static let labelsLead: CGFloat = 30
        static let textFieldsTop: CGFloat = 8
    }
}
