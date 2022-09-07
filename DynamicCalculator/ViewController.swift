//
//  ViewController.swift
//  DynamicCalculator
//
//  Created by Logan Miller on 2/18/22.
//
import RxCocoa
import RxSwift
import RxGesture
import TinyConstraints
import UIKit

class ViewController : UIViewController {
    
    enum Operations {
        case add, subtract, multiply, divide
    }
    
    fileprivate var disposeBag = DisposeBag()
    fileprivate let calculator = CalculatorViewModel()
    fileprivate var operationActive : Bool = false
    fileprivate var currentOperation : Operations?
    fileprivate var previousTerm : Double?
    fileprivate var nextTermStarted : Bool = false

    fileprivate let resultLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let topLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.textAlignment = .center
        label.text = "Dynamic Calculator"
        label.font = UIFont(name:"Helvetica-Bold", size: 24.0)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupLayout()
        setupViewBindings()
    }
    
    // Sets view controller layout constraints
    fileprivate func setupLayout() {
        let labelContainer = UIView ()
        view.addSubview(labelContainer)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        
        labelContainer.edgesToSuperview(excluding: .bottom)
        labelContainer.heightToSuperview(multiplier: 0.40)
        
        labelContainer.addSubview(topLabel)
        labelContainer.addSubview(resultLabel)
        
        topLabel.edgesToSuperview(excluding: .bottom)
        topLabel.heightToSuperview(multiplier: 0.40)
        
        resultLabel.rightToSuperview(offset: -10)
        resultLabel.leftToSuperview()
        resultLabel.bottomToSuperview()
        
        let numberPadContainer = calculator
        view.addSubview(numberPadContainer)
        numberPadContainer.translatesAutoresizingMaskIntoConstraints = false
        
        numberPadContainer.topToBottom(of: labelContainer)
        numberPadContainer.edgesToSuperview(excluding: .top)
        numberPadContainer.heightToSuperview(multiplier: 0.60)
    }
    
    // Responds to actions taken by the user
    fileprivate func setupViewBindings() {
        calculator.output
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _output in
                switch(_output) {
                case _ where _output.isNumeric :
                    if  (Double(String(self?.resultLabel.text ?? "")) ?? 0) == self?.previousTerm && !(self?.nextTermStarted ?? false) {
                        self?.resultLabel.text = String(_output)
                        self?.nextTermStarted = true
                    } else if self?.resultLabel.text == "0" {
                        self?.resultLabel.text = String(_output)
                    } else {
                        self?.resultLabel.text = (self?.resultLabel.text ?? "") + String(_output)
                    }
                case ".":
                    if !(self?.resultLabel.text?.contains(".") ?? false) {
                        self?.resultLabel.text = (self?.resultLabel.text ?? "") + "."
                    } else if self?.resultLabel.text?.contains(".") ?? false && self?.operationActive ?? false {
                        self?.resultLabel.text = "0."
                    } else {
                        // Do nothing
                    }
                case "+":
                    self?.previousTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                    self?.operationActive = true
                    self?.currentOperation = .add
                case "-":
                    self?.previousTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                    self?.operationActive = true
                    self?.currentOperation = .subtract
                case "x":
                    self?.previousTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                    self?.operationActive = true
                    self?.currentOperation = .multiply
                case "/":
                    self?.previousTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                    self?.operationActive = true
                    self?.currentOperation = .divide
                case "AC":
                    self?.resultLabel.text = "0"
                    self?.nextTermStarted = false
                    self?.previousTerm = nil
                case "+/-":
                    self?.resultLabel.text = String(-1 * (Double(String(self?.resultLabel.text ?? "")) ?? 0))
                    self?.removeTrailingZero()
                case "%":
                    self?.resultLabel.text = String((Double(String(self?.resultLabel.text ?? "")) ?? 0) / 100)
                    self?.removeTrailingZero()
                default:
                    switch(self?.currentOperation) {
                    case .add:
                        self?.resultLabel.text = String(Utility.formatDecimal((self?.previousTerm ?? 0) + (Double(String(self?.resultLabel.text ?? "")) ?? 0)))
                        self?.removeTrailingZero()
                        self?.previousTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                        self?.nextTermStarted = false
                    case .subtract:
                        self?.resultLabel.text = String(Utility.formatDecimal((self?.previousTerm ?? 0) - (Double(String(self?.resultLabel.text ?? "")) ?? 0)))
                        self?.removeTrailingZero()
                        self?.previousTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                        self?.nextTermStarted = false
                    case .multiply:
                        self?.resultLabel.text = String(Utility.formatDecimal((self?.previousTerm ?? 0) * (Double(String(self?.resultLabel.text ?? "")) ?? 0)))
                        self?.removeTrailingZero()
                        self?.previousTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                        self?.nextTermStarted = false
                    case .divide:
                        self?.resultLabel.text = String(Utility.formatDecimal((self?.previousTerm ?? 0) / (Double(String(self?.resultLabel.text ?? "")) ?? 0)))
                        self?.removeTrailingZero()
                        self?.previousTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                        self?.nextTermStarted = false
                    default:
                        break
                    }
                    break
                }
            }).disposed(by: disposeBag)
    }
    
    // Removes any trailing zeros from the value being stored in resultLabel if it is a whole number
    fileprivate func removeTrailingZero() {
        if Utility.formatNumber(Double(String(self.resultLabel.text ?? "")) ?? 0) {
            self.resultLabel.text = String(Int(Double(String(self.resultLabel.text ?? "")) ?? 0))
        }
    }
}

