//
//  IMCController.swift
//  IMC
//
//  Created by Andre Firmo on 22/01/23.
//

import UIKit

class IMCController: UIViewController {
    // MARK: - Properties
    
    var model: IMCInput
    var customView: IMCViewInput?
    
    // MARK: - Initializers
    init(model: IMCInput) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        customView = IMCView(output: self)
        view = customView as? UIView
    }
}

extension IMCController: IMCViewOutput {
    func getUserInput(model: IMCInformation) {
        self.model.loadIMC(model: model)
    }
    
    func showError() {
        self.customView?.displayError(viewController: self)
    }
}

extension IMCController: IMCModelOutput {
    func show(result: String) {
        self.customView?.displayImage(imageName: result)
    }
}
