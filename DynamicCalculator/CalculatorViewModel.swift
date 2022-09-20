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
    
    fileprivate var isConstraints : Bool = false
    
    fileprivate var prevIndex : Int = 0
    fileprivate let CAPACITY : Int = 19
    
    fileprivate var buttons = [UIButton]()
    fileprivate let operations : [String] = [".", "=", "+", "-", "x", "/", "AC", "+/-", "%"]
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if !isConstraints {
            setupButtons()
            setupConstraints()
        }
    }
    
    // Creates the buttons needed for the calculator
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
     
    // Adds constraints to the buttons in relation to each other
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
                buttons[i].rx.tap.subscribe(onNext: { _ in
                    self.output.accept(self.buttons[i].titleLabel?.text ?? "")
                    self.changeButtonBorder(index: i)
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
                buttons[i].rx.tap.subscribe(onNext: { _ in
                    self.output.accept(self.buttons[i].titleLabel?.text ?? "")
					self.highlightButtonBorder(index: i)
                }).disposed(by: disposeBag)
            }
        }
        NotificationCenter.default.rx.notification(UIDevice.orientationDidChangeNotification)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.handleOrientationChange()
            }).disposed(by: disposeBag)
        
    }
    
    // Tracks orientation changes
    internal func handleOrientationChange() {
        guard UIDevice.current.orientation != .faceUp || UIDevice.current.orientation != .faceDown else { return }
        guard self.isDevicePortrait() else { return }
        
        disposeBag = DisposeBag()
        self.removeAllConstraints()
        self.setupConstraints()
        self.layoutIfNeeded()
    }
    
    fileprivate func isDevicePortrait() -> Bool {
        return UIScreen.main.bounds.width < UIScreen.main.bounds.height
    }
    
	fileprivate func highlightButtonBorder (index : Int) {
		buttons[index].layer.borderWidth = 2
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
			self?.buttons[index].layer.borderWidth = 1
		})
	}
	
    fileprivate func changeButtonBorder (index : Int) {
        switch(index) {
        case 11, 16:
            buttons[prevIndex].layer.borderWidth = 1
            prevIndex = 0
        default:
            if prevIndex != 0 {
                buttons[prevIndex].layer.borderWidth = 1
            }
            buttons[index].layer.borderWidth = 3
            prevIndex = index
        }
    }
    
    public func removeAllConstraints() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}

