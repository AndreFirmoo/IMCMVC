//
//  IMCModel.swift
//  IMC
//
//  Created by Andre Firmo on 28/01/23.
//

import Foundation
final class IMCModel: IMCInput {
    
    var output: IMCModelOutput!
    
    func loadIMC(model: IMCInformation) {
        
        let calcule = model.userWeight / (model.userHeight * model.userHeight)
        if calcule <= 18.5 {
            self.output.show(result: "Magreza")
        } else if calcule >= 18.5 && calcule <= 24.9 {
            self.output.show(result: "Normal")
        } else if calcule >= 24.91 && calcule <= 29.9 {
            self.output.show(result: "Sobrepeso")
        } else if calcule >= 29.91 && calcule <= 34.9 {
            self.output.show(result:  "Obesidade")
        } else {
            self.output.show(result: "ObesidadeGrave")
        }
    }
}
