//
//  ViewModel.swift
//  DynamicCalculator
//
//  Created by Logan Miller on 2/22/22.
//

import UIKit
import RxSwift
import RxCocoa
import TinyConstraints

class CalculatorViewModel : UIView {
    enum Operations {
        case add, subtract, multiply, divide
    }    
    
    public var output = BehaviorRelay<String>(value: "0")
    private var disposeBag = DisposeBag()
    private var buttons = [UIButton]()
    private let operations : [String] = [".", "=", "+", "-", "x", "/", "AC", "+/-", "%"]
    private var prevIndex : Int = 0
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupButtons()
        setupConstraints()
    }
    
    fileprivate func setupButtons() {
        for i in 0..<19 {
            switch(i / 10) {
            case 1 :
                switch(i % 10) {
                case 0:
                    let button = UIButton()
                    button.setTitle(operations[i % 10], for: .normal)
                    button.layer.borderWidth = 1
                    button.layer.borderColor = UIColor.black.cgColor
                    button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
                    button.setTitleColor(.black, for: .normal)
                    button.backgroundColor = UIColor.lightGray
                    button.tag = 1
                    button.translatesAutoresizingMaskIntoConstraints = false
                    buttons.append(button)
                case 1...5 :
                    let button = UIButton()
                    button.setTitle(operations[i % 10], for: .normal)
                    button.layer.borderWidth = 1
                    button.layer.borderColor = UIColor.black.cgColor
                    button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
                    button.setTitleColor(.black, for: .normal)
                    button.backgroundColor = UIColor.orange
                    button.tag = 1
                    button.translatesAutoresizingMaskIntoConstraints = false
                    buttons.append(button)
                default:
                    let button = UIButton()
                    button.setTitle(operations[i % 10], for: .normal)
                    button.layer.borderWidth = 1
                    button.layer.borderColor = UIColor.black.cgColor
                    button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
                    button.setTitleColor(.black, for: .normal)
                    button.setTitleColor(UIColor.white, for: .normal)
                    button.backgroundColor = UIColor.darkGray
                    button.tag = 1
                    button.translatesAutoresizingMaskIntoConstraints = false
                    buttons.append(button)
                }
            default :
                let button = UIButton()
                button.setTitle(String(i), for: .normal)
                button.layer.borderWidth = 1
                button.layer.borderColor = UIColor.black.cgColor
                button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = UIColor.lightGray
                button.tag = 1
                button.translatesAutoresizingMaskIntoConstraints = false
                buttons.append(button)
            }
        }
    }
    fileprivate func setupConstraints() {
        for i in 0..<buttons.count {
            addSubview(buttons[i])
            switch(i / 10){
            case 1:
                switch (i) {
                case 10:
                    buttons[i].heightToSuperview(multiplier: 0.2)
                    buttons[i].widthToSuperview(multiplier: 0.25)
                    buttons[i].bottomToSuperview()
                    buttons[i].leftToRight(of: buttons[i - 10])
                case 11:
                    buttons[i].heightToSuperview(multiplier: 0.2)
                    buttons[i].widthToSuperview(multiplier: 0.25)
                    buttons[i].bottomToSuperview()
                    buttons[i].leftToRight(of: buttons[i - 1])
                case 12, 13, 14, 15:
                    buttons[i].heightToSuperview(multiplier: 0.2)
                    buttons[i].widthToSuperview(multiplier: 0.25)
                    buttons[i].bottomToTop(of: buttons[i - 1])
                    buttons[i].leftToRight(of: buttons[10])
                case 16:
                    buttons[i].heightToSuperview(multiplier: 0.2)
                    buttons[i].widthToSuperview(multiplier: 0.25)
                    buttons[i].bottomToTop(of: buttons[7])
                    buttons[i].leftToSuperview()
                default:
                    buttons[i].heightToSuperview(multiplier: 0.2)
                    buttons[i].widthToSuperview(multiplier: 0.25)
                    buttons[i].bottomToTop(of: buttons[i - 9])
                    buttons[i].leftToRight(of: buttons[i - 1])
                }
                buttons[i].rx.tap.subscribe(onNext: { _ in
                    self.output.accept(self.buttons[i].titleLabel?.text ?? "")
                    self.changeBtnBorder(index: i)
                }).disposed(by: disposeBag)
            default:
                switch(i) {
                case 0:
                    buttons[i].heightToSuperview(multiplier: 0.2)
                    buttons[i].widthToSuperview(multiplier: 0.5)
                    buttons[i].bottomToSuperview()
                case 1:
                    buttons[i].heightToSuperview(multiplier: 0.2)
                    buttons[i].widthToSuperview(multiplier: 0.25)
                    buttons[i].bottomToTop(of: buttons[i - 1])
                    buttons[i].leftToSuperview()
                case 2, 3:
                    buttons[i].heightToSuperview(multiplier: 0.2)
                    buttons[i].widthToSuperview(multiplier: 0.25)
                    buttons[i].bottomToTop(of: buttons[0])
                    buttons[i].leftToRight(of: buttons[i - 1])
                case 4,7:
                    buttons[i].heightToSuperview(multiplier: 0.2)
                    buttons[i].widthToSuperview(multiplier: 0.25)
                    buttons[i].bottomToTop(of: buttons[i - 3])
                    buttons[i].leftToSuperview()
                default:
                    buttons[i].heightToSuperview(multiplier: 0.2)
                    buttons[i].widthToSuperview(multiplier: 0.25)
                    buttons[i].bottomToTop(of: buttons[i - 3])
                    buttons[i].leftToRight(of: buttons[i - 1])
                }
                buttons[i].rx.tap.subscribe(onNext: { _ in
                    self.output.accept(self.buttons[i].titleLabel?.text ?? "")
                }).disposed(by: disposeBag)
            }
        }
        
    }
    
    private func changeBtnBorder (index : Int) {
        switch(index) {
        case 11, 16 :
            buttons[prevIndex].layer.borderWidth = 1
            prevIndex = 0
        default :
            if prevIndex != 0 {
                buttons[prevIndex].layer.borderWidth = 1
            }
            buttons[index].layer.borderWidth = 3
            prevIndex = index
        }
    }
    
    public func formatNumber(_ value:Double) -> Bool{
        let intVal = floor(value)
        if(value - intVal == 0){
            return true
        }
        else{
            return false
        }
    }
    
    public func formatDecimal(_ value:Double) -> Double{
        let result = Double(round(10000000000 * value)/10000000000)
        return result
    }    
}
