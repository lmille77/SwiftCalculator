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

enum Operations {
	case add, subtract, multiply, divide
}

class CalculatorViewModel : UIView {
	internal let regularCalculatorViewModel = RegularCalculatorViewModel()
	internal let extendedCalculatorViewModel = ExtendedCalculatorViewModel()
	
	func resetRegularButtonBorder() {
		regularCalculatorViewModel.resetButtonBorder();
	}
	
	func resetExtendedButtonBorder() {
		extendedCalculatorViewModel.resetButtonBorder();
	}
}

class RegularCalculatorViewModel : UIView {
	
	internal var output = BehaviorRelay<String>(value: "0")
	internal var disposeBag = DisposeBag()
	fileprivate var buttons = [UIButton]()
	
	fileprivate var isConstraints : Bool = false
	
	fileprivate var prevIndex : Int = 0
	fileprivate let CAPACITY : Int = 19
	
	fileprivate let operations : [String] = [".", "=", "+", "-", "x", "/", "AC", "+/-", "%"]
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		if !isConstraints {
			setupButtons()
			setupConstraints()
		}
	}
	
	fileprivate func setupButtons() {
		for i in 0..<CAPACITY {
			let button = UIButton()
			button.layer.borderWidth = 1
			button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
			button.translatesAutoresizingMaskIntoConstraints = false
			switch(i / 10) {
			case 1:
				button.setTitle(operations[i % 10], for: .normal)
				button.setTitleColor(.black, for: .normal)
				switch(i % 10) {
				case 0:
					button.backgroundColor = UIColor.lightGray
				case 1...5:
					button.backgroundColor = UIColor.orange
				default:
					button.setTitleColor(.white, for: .normal)
					button.backgroundColor = UIColor.darkGray
				}
				buttons.append(button)
			default:
				button.setTitle(String(i), for: .normal)
				button.setTitleColor(.black, for: .normal)
				button.backgroundColor = UIColor.lightGray
				buttons.append(button)
			}
		}
		isConstraints = true
	}
	 
	fileprivate func setupConstraints() {
		for i in 0..<buttons.count {
			addSubview(buttons[i])
			
			switch(i / 11) {
			case 1:
				buttons[i].heightToSuperview(multiplier: 0.2)
				buttons[i].widthToSuperview(multiplier: 0.25)
				
				switch (i) {
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
				buttons[i].rx.tap.subscribe(onNext: { [weak self]_ in
					self?.output.accept(self?.buttons[i].titleLabel?.text ?? "")
					self?.changeButtonBorder(index: i)
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
					buttons[i].leftToSuperview()
				case 1:
					buttons[i].bottomToTop(of: buttons[i - 1])
					buttons[i].leftToSuperview()
				case 2, 3:
					buttons[i].bottomToTop(of: buttons[0])
					buttons[i].leftToRight(of: buttons[i - 1])
				case 4,7:
					buttons[i].bottomToTop(of: buttons[i - 3])
					buttons[i].leftToSuperview()
				case 10:
					buttons[i].bottomToSuperview()
					buttons[i].leftToRight(of: buttons[i - 10])
				default:
					buttons[i].bottomToTop(of: buttons[i - 3])
					buttons[i].leftToRight(of: buttons[i - 1])
				}
				buttons[i].rx.tap.subscribe(onNext: { [weak self] _ in
					self?.output.accept(self?.buttons[i].titleLabel?.text ?? "")
					self?.highlightButtonBorder(index: i)
				}).disposed(by: disposeBag)
			}
		}
	}
	
	fileprivate func highlightButtonBorder (index : Int) {
		buttons[index].layer.borderWidth = 2
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
			self?.buttons[index].layer.borderWidth = 1
		})
	}
	
	fileprivate func resetButtonBorder() {
		if prevIndex != 0 {
			buttons[prevIndex].layer.borderWidth = 1
		}
	}
	
	fileprivate func changeButtonBorder (index : Int) {
		switch(index) {
		case 11, 16:
			resetButtonBorder()
			prevIndex = 0
		case 17, 18:
			resetButtonBorder()
			prevIndex = 0
			highlightButtonBorder(index: index)
		default:
			resetButtonBorder()
			buttons[index].layer.borderWidth = 3
			prevIndex = index
		}
	}
}

class ExtendedCalculatorViewModel : UIView {
	
	internal var output = BehaviorRelay<String>(value: "0")
	internal var disposeBag = DisposeBag()
	fileprivate var buttons = [UIButton]()
	
	fileprivate var isConstraints : Bool = false
	
	fileprivate var prevIndex : Int = 0
	fileprivate let CAPACITY : Int = 15
	
	fileprivate let operations : [String] = ["x²", "xⁿ", "eⁿ", "1/x", "(", "log₁₀", "π", "x!", "ln", ")", "sin", "tan", "cos", "√x", "ⁿ√x"]
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		if !isConstraints {
			setupButtons()
			setupConstraints()
		}
	}
	
	fileprivate func setupButtons() {
		for i in 0..<CAPACITY {
			let button = UIButton()
			button.layer.borderWidth = 1
			button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
			button.translatesAutoresizingMaskIntoConstraints = false
			button.setTitle(operations[i], for: .normal)
			button.setTitleColor(.white, for: .normal)
			button.backgroundColor = UIColor.darkGray
			buttons.append(button)
		}
		isConstraints = true
	}
	 
	fileprivate func setupConstraints() {
		for i in 0..<buttons.count {
			addSubview(buttons[i])
			
			buttons[i].widthToSuperview(multiplier: 0.33333)
			buttons[i].heightToSuperview(multiplier: 0.2)
			
			switch(i / 5) {
			case 0:
				switch(i / 1) {
				case 0:
					buttons[i].bottomToSuperview()
					buttons[i].leftToSuperview()

				default:
					buttons[i].bottomToTop(of: buttons[i - 1])
					buttons[i].leftToSuperview()

				}
			default:
				switch(i % 5) {
				case 0:
					buttons[i].bottomToSuperview()
					buttons[i].leftToRight(of: buttons[i - 5])
				default:
					buttons[i].bottomToTop(of: buttons[i - 1])
					buttons[i].leftToRight(of: buttons[i - 5])
				}
			}
		}
	}
	
	fileprivate func highlightButtonBorder (index : Int) {
		buttons[index].layer.borderWidth = 2
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
			self?.buttons[index].layer.borderWidth = 1
		})
	}
	
	fileprivate func resetButtonBorder() {
		if prevIndex != 0 {
			buttons[prevIndex].layer.borderWidth = 1
		}
	}
	
	fileprivate func changeButtonBorder (index : Int) {
		switch(index) {
		case 11, 16:
			resetButtonBorder()
			prevIndex = 0
		case 17, 18:
			resetButtonBorder()
			prevIndex = 0
			highlightButtonBorder(index: index)
		default:
			resetButtonBorder()
			buttons[index].layer.borderWidth = 3
			prevIndex = index
		}
	}
}

