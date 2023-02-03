//
//  IMCView.swift
//  IMC
//
//  Created by Andre Firmo on 22/01/23.
//

import UIKit

protocol IMCViewOutput: AnyObject {
    func getUserInput(model: IMCInformation)
    func showError()
}

protocol IMCViewInput: AnyObject {
    func displayImage(imageName: String)
    func displayError(viewController: UIViewController)
}

final class IMCView: UIView {
    
    // MARK: - Properties
    private weak var output: IMCViewOutput?

    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Informe seu peso e sua altura"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var userWeightTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        textField.placeholder = "Seu peso: 89.0"
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    lazy var userHeightTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        textField.placeholder = "Sua altura: 1.89"
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private lazy var imcImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var calculateIMCButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Calular", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(getUserInformations), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorModal: UIAlertController = {
        let alert = UIAlertController(title: "Erro", message: "Por gentileza coloque apenas numeros", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .default))
        return alert
    }()
    
    // MARK: - Initializers
    init(output: IMCViewOutput) {
        self.output = output
        super.init(frame: .zero)
        setupView()
        backgroundColor = .lightGray
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Get information User
    @objc func getUserInformations() {
        
        guard let userHeight = userHeightTextField.text?.replacingOccurrences(of: ",", with: "."),
              let userWeight = userWeightTextField.text?.replacingOccurrences(of: ",", with: "."),
              let userHeightDouble = Double(userHeight),
              let userWeightDouble = Double(userWeight)
        else {
            output?.showError()
            return
        }
        
        let model = IMCInformation(userHeight: userHeightDouble, userWeight: userWeightDouble)
        output?.getUserInput(model: model)
    }
}

extension IMCView: IMCViewInput {
    // MARK: - Display Image

    func displayImage(imageName: String) {
        self.imcImageView.isHidden = false
        self.imcImageView.image = UIImage(named: imageName)
        endEditing(true)
    }
    
    // MARK: - Display Error
    
    func displayError(viewController: UIViewController) {
        viewController.present(errorModal, animated: true)
    }
}

// MARK: - View's Configuration
extension IMCView: CodeView {
    
    func setupComponents() {
        addSubview(informationLabel)
        addSubview(userWeightTextField)
        addSubview(userHeightTextField)
        addSubview(imcImageView)
        addSubview(calculateIMCButton)
    }
    
    func setupConstraints() {
        setupConstraintsInformationLabel()
        setupConstraintsUserWeightTextField()
        setupConstraintsUserHeightTextField()
        setupConstraintsImcImageView()
        setupConstraintsCalculateIMCButton()
    }

    private func setupConstraintsInformationLabel() {
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            informationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            informationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
    
    private func setupConstraintsUserWeightTextField() {
        NSLayoutConstraint.activate([
            userWeightTextField.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 30),
            userWeightTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            userWeightTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
    
    private func setupConstraintsUserHeightTextField() {
        NSLayoutConstraint.activate([
            userHeightTextField.topAnchor.constraint(equalTo: userWeightTextField.bottomAnchor, constant: 30),
            userHeightTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            userHeightTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        ])
    }
    
    private func setupConstraintsImcImageView() {
        NSLayoutConstraint.activate([
            imcImageView.topAnchor.constraint(equalTo: userHeightTextField.bottomAnchor, constant: 30),
            imcImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imcImageView.heightAnchor.constraint(equalToConstant: 150),
            imcImageView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupConstraintsCalculateIMCButton() {
        let lowPriorityBottomAnchor = calculateIMCButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        lowPriorityBottomAnchor.priority = .defaultLow
        NSLayoutConstraint.activate([
            calculateIMCButton.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor, constant: -15),
            calculateIMCButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            calculateIMCButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            calculateIMCButton.heightAnchor.constraint(equalToConstant: 50),
            lowPriorityBottomAnchor
        ])
    }
}
