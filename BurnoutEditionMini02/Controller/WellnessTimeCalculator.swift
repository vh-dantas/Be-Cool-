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
    //guarda os valores dos sliders
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
    
    func calculateRemainingTime(wellnessDates: [Date]) -> (Int, Int) {
        // Chamando a função calculateResult para obter as horas e minutos de bem-estar calculados
        let (resultHours, resultMinutes) = calculateResult()
        
        // Calculando a soma das horas e minutos das wellnessDates
        let calendar = Calendar.current
        var totalWellnessHours = 0
        var totalWellnessMinutes = 0
        
        for date in wellnessDates {
            let components = calendar.dateComponents([.hour, .minute], from: date)
            totalWellnessHours += components.hour ?? 0
            totalWellnessMinutes += components.minute ?? 0
        }
        
        // Subtraindo as horas e minutos de bem-estar das wellnessDates dos resultados
        var remainingHours = resultHours - totalWellnessHours
        var remainingMinutes = resultMinutes - totalWellnessMinutes
        
        // Certificando-se de que os minutos não sejam negativos
        if remainingMinutes < 0 {
            remainingHours -= 1
            remainingMinutes += 60
        }
        
        return (remainingHours, remainingMinutes)
    }

}
