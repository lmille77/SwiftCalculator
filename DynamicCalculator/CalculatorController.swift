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

class CalculatorController : UIViewController {
	
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
		label.text = "Miller Calculator"
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
		
		let numberPadContainer = UIView()
		view.addSubview(numberPadContainer)
		numberPadContainer.translatesAutoresizingMaskIntoConstraints = false
		
		numberPadContainer.topToBottom(of: labelContainer)
		numberPadContainer.edgesToSuperview(excluding: .top)
		numberPadContainer.heightToSuperview(multiplier: 0.60)
		
		if !Utility.isPortrait() {
			numberPadContainer.addSubview(calculator.regularCalculatorViewModel)
			numberPadContainer.addSubview(calculator.extendedCalculatorViewModel)
			
			calculator.regularCalculatorViewModel.widthToSuperview(multiplier: 0.57)
			calculator.regularCalculatorViewModel.rightToSuperview()
			calculator.regularCalculatorViewModel.heightToSuperview()
			
			calculator.extendedCalculatorViewModel.rightToLeft(of: calculator.regularCalculatorViewModel)
			calculator.extendedCalculatorViewModel.leftToSuperview()
			calculator.extendedCalculatorViewModel.heightToSuperview()
		} else {
			numberPadContainer.addSubview(calculator.regularCalculatorViewModel)
			calculator.regularCalculatorViewModel.edgesToSuperview()
		}
	}
	
	// Responds to actions taken by the user
	fileprivate func setupViewBindings() {
		
		NotificationCenter.default.rx.notification(UIDevice.orientationDidChangeNotification)
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { [weak self] _ in
				self?.handleOrientationChange()
			}).disposed(by: disposeBag)
		
		calculator.regularCalculatorViewModel.output
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { [weak self] input in
				
				let resultText = self?.resultLabel.text ?? ""
				let resultTextToDouble = Double(resultText) ?? 0
				let previousTerm = self?.previousTerm ?? 0
				
				switch(input) {
				case _ where input.isNumeric :
					if resultText == "0" || resultText.isEmpty {
						self?.resultLabel.text = input
					} else if (resultTextToDouble == previousTerm
							   && !(self?.nextTermStarted ?? false)
							   && resultTextToDouble != 0.0) {
						self?.resultLabel.text = input
						self?.nextTermStarted = true
					} else {
						self?.resultLabel.text = resultText + input
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
					let tempValue = -1 * resultTextToDouble
					self?.resultLabel.text = tempValue.clean
				case "%":
					let tempValue = resultTextToDouble / 100
					self?.resultLabel.text = tempValue.clean
				default:
					switch(self?.currentOperation) {
					case .add:
						let tempValue = Utility.formatDecimal(previousTerm + resultTextToDouble)
						self?.resultLabel.text = tempValue.clean
						self?.previousTerm = resultTextToDouble
						self?.nextTermStarted = false
						self?.operationActive = false
					case .subtract:
						let tempValue = Utility.formatDecimal(previousTerm - resultTextToDouble)
						self?.resultLabel.text = tempValue.clean
						self?.previousTerm = resultTextToDouble
						self?.nextTermStarted = false
						self?.operationActive = false
					case .multiply:
						let tempValue = Utility.formatDecimal(previousTerm * resultTextToDouble)
						self?.resultLabel.text = tempValue.clean
						self?.previousTerm = resultTextToDouble
						self?.nextTermStarted = false
						self?.operationActive = false
					case .divide:
						let tempValue = Utility.formatDecimal(previousTerm / resultTextToDouble)
						self?.resultLabel.text = tempValue.clean
						self?.previousTerm = resultTextToDouble
						self?.nextTermStarted = false
						self?.operationActive = false
					default:
						break
					}
					self?.resultLabel.text = Utility.formatResultLabel(self?.resultLabel.text ?? "")
					break
				}

			}).disposed(by: disposeBag)
		
		calculator.extendedCalculatorViewModel.output
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: { [weak self] input in
				
				let resultText = self?.resultLabel.text ?? ""
				let resultTextToDouble = Double(resultText) ?? 0
				let previousTerm = self?.previousTerm ?? 0
				
				switch(input) {
				default:
					self?.calculator.resetRegularButtonBorder()
				}

			}).disposed(by: disposeBag)
	}
	
	internal func handleOrientationChange() {
		guard UIDevice.current.orientation != .faceUp || UIDevice.current.orientation != .faceDown else { return }
		
		self.removeAllConstraints()
		self.setupLayout()
	}
	
	public func removeAllConstraints() {
		self.view.subviews.forEach({ $0.removeFromSuperview() })
	}
}



