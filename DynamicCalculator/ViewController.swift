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
    
    fileprivate let topLabel : UILabel = {
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
                
                let resultText = self?.resultLabel.text ?? ""
                let resultTextToDouble = Double(resultText) ?? 0
                let previousTerm = self?.previousTerm ?? 0
                
                switch(_output) {
                case _ where _output.isNumeric :
                    if resultText == "0" || resultText.isEmpty {
                        self?.resultLabel.text = _output
                    } else if (resultTextToDouble == previousTerm
                               && !(self?.nextTermStarted ?? false)
                               && resultTextToDouble != 0.0) {
                        self?.resultLabel.text = _output
                        self?.nextTermStarted = true
                    } else {
                        self?.resultLabel.text = resultText + _output
                    }
                case ".":
                    if !(self?.resultLabel.text?.contains(".") ?? false) {
                        self?.resultLabel.text = resultText + "."
                    } else if self?.resultLabel.text?.contains(".") ?? false && self?.operationActive ?? false {
                        self?.resultLabel.text = "0."
                    } else {
                        // Do nothing
                    }
                case "+":
                    self?.previousTerm = resultTextToDouble
                    self?.operationActive = true
                    self?.currentOperation = .add
                case "-":
                    self?.previousTerm = resultTextToDouble
                    self?.operationActive = true
                    self?.currentOperation = .subtract
                case "x":
                    self?.previousTerm = resultTextToDouble
                    self?.operationActive = true
                    self?.currentOperation = .multiply
                case "/":
                    self?.previousTerm = resultTextToDouble
                    self?.operationActive = true
                    self?.currentOperation = .divide
                case "AC":
                    self?.resultLabel.text = "0"
                    self?.operationActive = false
                    self?.nextTermStarted = false
                    self?.previousTerm = nil
                case "+/-":
                    self?.resultLabel.text = String(-1 * resultTextToDouble)
                    self?.resultLabel.text = Utility.removeTrailingZero(resultText)
                case "%":
                    self?.resultLabel.text = String(resultTextToDouble / 100)
                    self?.resultLabel.text = Utility.removeTrailingZero(resultText)
                default:
                    switch(self?.currentOperation) {
                    case .add:
                        self?.resultLabel.text = String(Utility.formatDecimal(previousTerm + resultTextToDouble))
                        self?.resultLabel.text = Utility.removeTrailingZero(self?.resultLabel.text ?? "")
                        self?.previousTerm = resultTextToDouble
                        self?.nextTermStarted = false
                        self?.operationActive = false
                    case .subtract:
                        self?.resultLabel.text = String(Utility.formatDecimal(previousTerm - resultTextToDouble))
                        self?.resultLabel.text = Utility.removeTrailingZero(self?.resultLabel.text ?? "")
                        self?.previousTerm = resultTextToDouble
                        self?.nextTermStarted = false
                        self?.operationActive = false
                    case .multiply:
                        self?.resultLabel.text = String(Utility.formatDecimal(previousTerm * resultTextToDouble))
                        self?.resultLabel.text = Utility.removeTrailingZero(self?.resultLabel.text ?? "")
                        self?.previousTerm = resultTextToDouble
                        self?.nextTermStarted = false
                        self?.operationActive = false
                    case .divide:
                        self?.resultLabel.text = String(Utility.formatDecimal(previousTerm / resultTextToDouble))
                        self?.resultLabel.text = Utility.removeTrailingZero(self?.resultLabel.text ?? "")
                        self?.previousTerm = resultTextToDouble
                        self?.nextTermStarted = false
                        self?.operationActive = false
                    default:
                        break
                    }
                    break
                }
            }).disposed(by: disposeBag)
    }
}

