//
//  ViewModel.swift
//  DynamicCalculator
//
//  Created by Logan Miller on 2/22/22.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel{
    public var output = BehaviorRelay<String>(value: "0")
    
    static var firstNumber:Double = 0.0
    static var secondNumber:Double = 0.0
    static var newOperation:Bool = false
    static var decimalAdded:Bool = false
    
    enum Operations{
        case add,subtract,multiply,divide
    }
    private var currentOperation: Operations?
    
    public func buttonPressed(_ number: Int) {
        let currentValue = output.value
        var concatString:String = ""
        
        if (currentValue == "0" && number < 10){
            concatString = String(number);
        }
        else if (ViewModel.firstNumber != 0 && ViewModel.firstNumber == Double(currentValue) && number < 10){
            concatString = String(number)
        }
        else if number < 10{
            concatString = String(currentValue) + String(number);
        }
        else if(number == 10 && ViewModel.decimalAdded == false){
            if(ViewModel.firstNumber == Double(currentValue)){
                concatString = ("0") + (".")
                ViewModel.decimalAdded = true
            }
            else{
                concatString = String(currentValue) + (".")
                ViewModel.decimalAdded = true
            }
        }
        else if number == 11{
            ViewModel.secondNumber = Double(currentValue)!
            if let operation = currentOperation{
                switch(operation){
                case .add:
                    let result = ViewModel.firstNumber + ViewModel.secondNumber
                    if(formatNumber(result)){
                        let formattedValue = String(format: "%.0f", result)
                        concatString = formattedValue
                    }
                    else{
                        let roundedResult = formatDecimal(result)
                        concatString = String(roundedResult)
                    }
                    if(ViewModel.newOperation == false){
                        ViewModel.firstNumber = ViewModel.secondNumber
                    }
                    ViewModel.newOperation = true
                    ViewModel.decimalAdded = false
                    break
                    
                case.subtract:
                    let result = ViewModel.firstNumber - ViewModel.secondNumber
                    if(formatNumber(result)){
                        let formattedValue = String(format: "%.0f", result)
                        concatString = formattedValue
                    }
                    else{
                        let roundedResult = formatDecimal(result)
                        concatString = String(roundedResult)
                    }
                    if(ViewModel.newOperation == false){
                        ViewModel.firstNumber = ViewModel.secondNumber
                    }
                    ViewModel.newOperation = true
                    ViewModel.decimalAdded = false
                    break
                    
                case.multiply:
                    let result = ViewModel.firstNumber * ViewModel.secondNumber
                    if(formatNumber(result)){
                        let formattedValue = String(format: "%.0f", result)
                        concatString = formattedValue
                    }
                    else{
                        let roundedResult = formatDecimal(result)
                        concatString = String(roundedResult)
                    }
                    if(ViewModel.newOperation == false){
                        ViewModel.firstNumber = ViewModel.secondNumber
                    }
                    ViewModel.newOperation = true
                    ViewModel.decimalAdded = false
                    break
                    
                case.divide:
                    let result = ViewModel.firstNumber / ViewModel.secondNumber
                    if(formatNumber(result)){
                        let formattedValue = String(format: "%.0f", result)
                        concatString = formattedValue
                    }
                    else{
                        let roundedResult = formatDecimal(result)
                        concatString = String(roundedResult)
                    }
                    if(ViewModel.newOperation == false){
                        ViewModel.firstNumber = ViewModel.secondNumber
                    }
                    ViewModel.newOperation = true
                    ViewModel.decimalAdded = false
                    break                    
                }
            }
            
        }
        else if number == 12{
            currentOperation = .add
            ViewModel.decimalAdded = false
            ViewModel.firstNumber = Double(currentValue)!
        }
        else if number == 13{
            currentOperation = .subtract
            ViewModel.decimalAdded = false
            ViewModel.firstNumber = Double(currentValue)!
        }
        else if number == 14{
            currentOperation = .multiply
            ViewModel.decimalAdded = false
            ViewModel.firstNumber = Double(currentValue)!
        }
        else if number == 15{
            currentOperation = .divide
            ViewModel.decimalAdded = false
            ViewModel.firstNumber = Double(currentValue)!
        }
        else if number == 16{
            concatString = ("0")
            ViewModel.firstNumber = 0.0
            ViewModel.secondNumber = 0.0
            ViewModel.newOperation = false
            ViewModel.decimalAdded = false
        }
        else if number == 17{
            if formatNumber(Double(currentValue)!){
                concatString = (String)(-1 * Int(currentValue)!)
            }
            else{
                concatString = (String)(-1 * Double(currentValue)!)
            }
        }
        else if (number == 18 && currentValue != "0"){
            if(formatNumber(0.01 * Double(currentValue)!)){
                let formattedValue = String(format: "%.0f", (0.01 * Double(currentValue)!))
                concatString = formattedValue
            }
            else{
                concatString = (String)(0.01 * Double(currentValue)!)
            }
        }
        if concatString != ""{
            output.accept(concatString)
        }
        
    }
    
    @objc
    private func formatNumber(_ value:Double) -> Bool{
        let intVal = floor(value)
        if(value - intVal == 0){
            return true
        }
        else{
            return false
        }
    }
    
    @objc
    private func formatDecimal(_ value:Double) -> Double{
        let result = Double(round(10000000000 * value)/10000000000)
        return result
    }    
}
