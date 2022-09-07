//
//  Utility.swift
//  DynamicCalculator
//
//  Created by Logan Miller on 9/7/22.
//

import Foundation

class Utility {
    public static func formatNumber(_ value : Double) -> Bool{
        return value - floor(value) == 0
    }
    
    public static func formatDecimal(_ value : Double) -> Double{
        return Double(round(10000000000 * value)/10000000000)
    }
}

extension String {
    public var isNumeric : Bool {
        return Double(self) != nil
    }
}
