//
//  Presenter.swift
//  HomeWork9
//
//  Created by Роман on 11.07.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Foundation

class Presenter {
    
    struct MeasurentPattern {
        let pattern: String
        let unit: Unit
    }
    
    let patterns = ["((0[1-9]|[12]\\d|3[01])((\\/)|(.)|(-)|( ))(0[1-9]|1[0-2])((\\/)|(.)|(-)|( ))[12]\\d{3})",
                    "(([12]\\d{3})((\\/)|(.)|(-)|( ))(0[1-9]|1[0-2])((\\/)|(.)|(-)|( ))(0[1-9]|[12]\\d|3[01]))",
                    "(([0-2][0-9]|(3)[0-1])((\\/)|(.)|(-)|( ))(\\w+)((\\/)|(.)|(-)|( ))\\d{4})"]
    
    // Основные единицы
    let unitPatterns = [MeasurentPattern(pattern: "\\d+((.|,)\\d+) ((kilometer((s)|())((s)|()))|(km)|(километров)|(км))", unit: UnitLength.kilometers),
                        MeasurentPattern(pattern: "\\d+((.|,)\\d+) ((meter((s)|()))|(mt)|(метров)|(м))", unit: UnitLength.meters),
                        MeasurentPattern(pattern: "\\d+((.|,)\\d+) ((mile((s)|()))|(m)|(мил((я)|(ь))))", unit: UnitLength.miles),
                        MeasurentPattern(pattern: "\\d+((.|,)\\d+) ((kilogram((s)|()))|(kg)|(килограмм)|(кг))", unit: UnitMass.kilograms),
                        MeasurentPattern(pattern: "\\d+((.|,)\\d+) ((second((s)|()))|(s)|(секунда)|(с))", unit: UnitDuration.seconds),
                        MeasurentPattern(pattern: "\\d+((.|,)\\d+) ((ampere((s)|()))|(А)|(ампер)|(A))", unit: UnitElectricCurrent.amperes),
                        MeasurentPattern(pattern: "\\d+((.|,)\\d+) ((watt((s)|()))|(W)|(ватт)|(Вт))", unit: UnitPower.watts),
                        MeasurentPattern(pattern: "\\d+((.|,)\\d+) ((hertz((s)|()))|(Hz)|(герц)|(Гц))", unit: UnitFrequency.hertz)]

    func getDateText(text: String, locale: Locale? = Locale(identifier: "ru_RU")) -> String {
        var result = text
        
        let _ = self.patterns.compactMap { pattern in
            let datesText = text.regex(pattern: pattern)

            let _ = datesText.compactMap { text in
                let date = getDate(dateText: text)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM yyyy"
                dateFormatter.locale = locale
                
                result = result.replacingOccurrences(of: text, with: dateFormatter.string(from: date ?? Date()))
            }
        }
        
        return result
    }
    
    func getMeasurentText(text: String, locale: Locale? = Locale(identifier: "ru_RU")) -> String {
        var result = text
        
        let _ = self.unitPatterns.compactMap { unitPattern in
            let measurementTexts = text.regex(pattern: unitPattern.pattern)

            let _ = measurementTexts.compactMap { text in
                guard let number = text.split(separator: " ").first?.toDouble() else { return }
                let measurement = Measurement(value: number, unit: unitPattern.unit)
                let measurementFormatter = MeasurementFormatter()
                measurementFormatter.locale = locale
                let measurementText = measurementFormatter.string(from: measurement)
                
                
                result = result.replacingOccurrences(of: text, with: measurementText)
            }
        }
        
        return result
    }
    
    private func getDate(dateText: String) -> Date? {
        let dateFormatter = DateFormatter()
        
        return dateFormatter.date(from: dateText)
    }
}
