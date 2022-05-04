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
    fileprivate var firstTerm : Double = -1
    
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
    
    fileprivate func setupViewBindings() {
        calculator.output
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _output in
                switch(_output) {
                case _ where _output.isNumeric :
                    if  (Double(String(self?.resultLabel.text ?? "")) ?? 0) == self?.firstTerm {
                        self?.resultLabel.text = String(_output)
                    } else if self?.resultLabel.text == "0" {
                        self?.resultLabel.text = String(_output)
                    } else {
                        self?.resultLabel.text = (self?.resultLabel.text ?? "") + String(_output)
                    }
                case ".":
                    self?.resultLabel.text = (self?.resultLabel.text ?? "") + "."
                case "+":
                    self?.firstTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                    self?.operationActive = true
                    self?.currentOperation = .add
                case "-":
                    self?.firstTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                    self?.operationActive = true
                    self?.currentOperation = .subtract
                case "x":
                    self?.firstTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                    self?.operationActive = true
                    self?.currentOperation = .multiply
                case "/":
                    self?.firstTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                    self?.operationActive = true
                    self?.currentOperation = .divide
                case "AC":
                    self?.resultLabel.text = "0"
                case "+/-":
                    self?.resultLabel.text = String(-1 * (Double(String(self?.resultLabel.text ?? "")) ?? 0))
                    self?.removeTrailingZero()
                case "%":
                    self?.resultLabel.text = String((Double(String(self?.resultLabel.text ?? "")) ?? 0) / 100)
                    self?.removeTrailingZero()
                default:
                    switch(self?.currentOperation) {
                    case .add:
                        self?.resultLabel.text = String(self?.calculator.formatDecimal((self?.firstTerm ?? 0) + (Double(String(self?.resultLabel.text ?? "")) ?? 0)) ?? 0)
                        self?.removeTrailingZero()
                        self?.firstTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                    case .subtract:
                        self?.resultLabel.text = String(self?.calculator.formatDecimal((self?.firstTerm ?? 0) - (Double(String(self?.resultLabel.text ?? "")) ?? 0)) ?? 0)
                        self?.removeTrailingZero()
                        self?.firstTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                    case .multiply:
                        self?.resultLabel.text = String(self?.calculator.formatDecimal((self?.firstTerm ?? 0) * (Double(String(self?.resultLabel.text ?? "")) ?? 0)) ?? 0)
                        self?.removeTrailingZero()
                        self?.firstTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                    case .divide:
                        self?.resultLabel.text = String(self?.calculator.formatDecimal((self?.firstTerm ?? 0) / (Double(String(self?.resultLabel.text ?? "")) ?? 0)) ?? 0)
                        self?.removeTrailingZero()
                        self?.firstTerm = (Double(String(self?.resultLabel.text ?? "")) ?? 0)
                    default:
                        break
                    }
                    break
                }
            }).disposed(by: disposeBag)
    }
    
    fileprivate func removeTrailingZero () {
        if self.calculator.formatNumber(Double(String(self.resultLabel.text ?? "")) ?? 0) {
            self.resultLabel.text = String(Int(Double(String(self.resultLabel.text ?? "")) ?? 0))
        }
    }
    
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
}

extension String {
    var isNumeric : Bool {
        return Double(self) != nil
    }
}

