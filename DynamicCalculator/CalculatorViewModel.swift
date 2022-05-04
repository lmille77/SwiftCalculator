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
    public var output = BehaviorRelay<String>(value: "0")
    fileprivate var disposeBag = DisposeBag()
    fileprivate var buttons = [UIButton]()
    fileprivate let operations : [String] = [".", "=", "+", "-", "x", "/", "AC", "+/-", "%"]
    fileprivate var prevIndex : Int = 0
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setupButtons()
        setupConstraints()
    }
    
    fileprivate func setupButtons() {
        for i in 0..<19 {
            let button = UIButton()
            button.layer.borderWidth = 1
            button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
            button.translatesAutoresizingMaskIntoConstraints = false
            switch(i / 10) {
            case 1 :
                button.setTitle(operations[i % 10], for: .normal)
                button.setTitleColor(.black, for: .normal)
                switch(i % 10) {
                case 0:
                    button.backgroundColor = UIColor.lightGray
                case 1...5 :
                    button.backgroundColor = UIColor.orange
                default:
                    button.setTitleColor(.white, for: .normal)
                    button.backgroundColor = UIColor.darkGray
                }
                buttons.append(button)
            default :
                button.setTitle(String(i), for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = UIColor.lightGray
                buttons.append(button)
            }
        }
    }
     
    fileprivate func setupConstraints() {
        for i in 0..<buttons.count {
            addSubview(buttons[i])
            switch(i / 10){
            case 1:
                buttons[i].heightToSuperview(multiplier: 0.2)
                buttons[i].widthToSuperview(multiplier: 0.25)
                switch (i) {
                case 10:
                    buttons[i].bottomToSuperview()
                    buttons[i].leftToRight(of: buttons[i - 10])
                case 11:
                    buttons[i].bottomToSuperview()
                    buttons[i].leftToRight(of: buttons[i - 1])
                case 12, 13, 14, 15:
                    buttons[i].bottomToTop(of: buttons[i - 1])
                    buttons[i].leftToRight(of: buttons[10])
                case 16:
                    buttons[i].bottomToTop(of: buttons[7])
                    buttons[i].leftToSuperview()
                default:
                    buttons[i].bottomToTop(of: buttons[i - 9])
                    buttons[i].leftToRight(of: buttons[i - 1])
                }
                buttons[i].rx.tap.subscribe(onNext: { _ in
                    self.output.accept(self.buttons[i].titleLabel?.text ?? "")
                    self.changeBtnBorder(index: i)
                }).disposed(by: disposeBag)
            default:
                if i != 0 {
                    buttons[i].heightToSuperview(multiplier: 0.2)
                    buttons[i].widthToSuperview(multiplier: 0.25)
                }
                switch(i) {
                case 0:
                    buttons[i].heightToSuperview(multiplier: 0.2)
                    buttons[i].widthToSuperview(multiplier: 0.5)
                    buttons[i].bottomToSuperview()
                case 1:
                    buttons[i].bottomToTop(of: buttons[i - 1])
                    buttons[i].leftToSuperview()
                case 2, 3:
                    buttons[i].bottomToTop(of: buttons[0])
                    buttons[i].leftToRight(of: buttons[i - 1])
                case 4,7:
                    buttons[i].bottomToTop(of: buttons[i - 3])
                    buttons[i].leftToSuperview()
                default:
                    buttons[i].bottomToTop(of: buttons[i - 3])
                    buttons[i].leftToRight(of: buttons[i - 1])
                }
                buttons[i].rx.tap.subscribe(onNext: { _ in
                    self.output.accept(self.buttons[i].titleLabel?.text ?? "")
                }).disposed(by: disposeBag)
            }
        }
        
    }
    
    fileprivate func changeBtnBorder (index : Int) {
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
        return value - floor(value) == 0
    }
    
    public func formatDecimal(_ value:Double) -> Double{
        return Double(round(10000000000 * value)/10000000000)
    }
}
