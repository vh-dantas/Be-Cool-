//
//  WellnessTimeCalculator.swift
//  BurnoutEditionMini02
//
//  Created by Thayna Rodrigues on 04/10/23.
//
import Foundation

// Essa classe calcula o valor necessário das metas de bem estar
class Calculator {
    static let shared = Calculator()
    var savedValues: [Int: Float] = [:]
    let balance: Float = 0.3

    func calculateResult() -> (Int, Int) {
        var sum: Float = 0
        for value in savedValues.values {
            sum += value
        }
        print("total de horas de trabalho em minutos: \(sum)")
        let resultMinutes = (sum * balance)
        let roundedResultMinutes = round(resultMinutes)
        print("total de horas de bem-estar em minutos: \(resultMinutes)")
        let hours = Int(roundedResultMinutes) / 60
        let minutes = Int(roundedResultMinutes) % 60
        print("horas de bem-estar recomendadas: \(hours) hora(s) e \(minutes) minutos")
        return (hours, minutes)
    }
    
    func calculateRemainingTime() {
        return 
    }
}
