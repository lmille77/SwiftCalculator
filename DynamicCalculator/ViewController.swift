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

class ViewController: UIViewController {
    private var prevTag:Int = 0
    private var disposeBag = DisposeBag()
    private var viewModel: ViewModel!
    
    private func setupViewBindings() {
        viewModel.output
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] newOutput in
                self?.resultLabel.text = String(newOutput)
            }).disposed(by: disposeBag)
    }
    
    static func create(_ value: ViewModel) -> ViewController {
        let vc = ViewController()
        vc.viewModel = value
        vc.setupViewBindings()
        return vc
    }
    
    let resultLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let topLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.textAlignment = .center
        label.text = "Dynamic Calculator"
        label.font = UIFont(name:"Helvetica-Bold", size: 24.0)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let zeroButton:UIButton = {
        let button = UIButton()
        button.setTitle("0", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let oneButton:UIButton = {
        let button = UIButton()
        button.setTitle("1", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.tag = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let twoButton:UIButton = {
        let button = UIButton()
        button.setTitle("2", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.tag = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let threeButton:UIButton = {
        let button = UIButton()
        button.setTitle("3", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.tag = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let fourButton:UIButton = {
        let button = UIButton()
        button.setTitle("4", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.tag = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let fiveButton:UIButton = {
        let button = UIButton()
        button.setTitle("5", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.tag = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let sixButton:UIButton = {
        let button = UIButton()
        button.setTitle("6", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.tag = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let sevenButton:UIButton = {
        let button = UIButton()
        button.setTitle("7", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.tag = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let eightButton:UIButton = {
        let button = UIButton()
        button.setTitle("8", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.tag = 9
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nineButton:UIButton = {
        let button = UIButton()
        button.setTitle("9", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.tag = 10;
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let deciButton:UIButton = {
        let button = UIButton()
        button.setTitle(".", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.tag = 11
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let equalButton:UIButton = {
        let button = UIButton()
        button.setTitle("=", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.orange
        button.tag = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let plusButton:UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.orange
        button.tag = 13
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let minusButton:UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.orange
        button.tag = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let multButton:UIButton = {
        let button = UIButton()
        button.setTitle("x", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.orange
        button.tag = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let divideButton:UIButton = {
        let button = UIButton()
        button.setTitle("/", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.orange
        button.tag = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let acButton:UIButton = {
        let button = UIButton()
        button.setTitle("AC", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.darkGray
        button.tag = 17
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let posnegButton:UIButton = {
        let button = UIButton()
        button.setTitle("+/-", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.darkGray
        button.tag = 18
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let percButton:UIButton = {
        let button = UIButton()
        button.setTitle("%", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.darkGray
        button.tag = 19
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout(){
        
        let labelContainer = UIView()
        view.addSubview(labelContainer)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        
        labelContainer.edgesToSuperview(excluding: .bottom)
        labelContainer.heightToSuperview(multiplier: 0.40)
        
        labelContainer.addSubview(topLabel)
        labelContainer.addSubview(resultLabel)
        
        topLabel.edgesToSuperview(excluding: .bottom)
        topLabel.heightToSuperview(multiplier: 0.40)
        
        let numPadding = UIView()
        view.addSubview(numPadding)
        numPadding.translatesAutoresizingMaskIntoConstraints = false
        
        numPadding.topToBottom(of: topLabel)
        numPadding.rightToSuperview()
        numPadding.width(to: labelContainer, multiplier: 0.02)
        
        resultLabel.rightToLeft(of: numPadding)
        resultLabel.leftToSuperview()
        resultLabel.bottomToSuperview()
        
        
        let numberPadContainer = UIView()
        view.addSubview(numberPadContainer)
        numberPadContainer.translatesAutoresizingMaskIntoConstraints = false
        
        numberPadContainer.topToBottom(of: labelContainer)
        numberPadContainer.edgesToSuperview(excluding: .top)
        numberPadContainer.height(to: view, multiplier: 0.60)
        
        numberPadContainer.addSubview(zeroButton)
        numberPadContainer.addSubview(oneButton)
        numberPadContainer.addSubview(twoButton)
        numberPadContainer.addSubview(threeButton)
        numberPadContainer.addSubview(fourButton)
        numberPadContainer.addSubview(fiveButton)
        numberPadContainer.addSubview(sixButton)
        numberPadContainer.addSubview(sevenButton)
        numberPadContainer.addSubview(eightButton)
        numberPadContainer.addSubview(nineButton)
        numberPadContainer.addSubview(deciButton)
        numberPadContainer.addSubview(equalButton)
        numberPadContainer.addSubview(plusButton)
        numberPadContainer.addSubview(minusButton)
        numberPadContainer.addSubview(multButton)
        numberPadContainer.addSubview(divideButton)
        numberPadContainer.addSubview(acButton)
        numberPadContainer.addSubview(posnegButton)
        numberPadContainer.addSubview(percButton)
        
        zeroButton.height(to: numberPadContainer, multiplier: 0.2)
        zeroButton.width(to: numberPadContainer, multiplier: 0.5)
        zeroButton.bottomToSuperview()
        
        zeroButton.rx.tap.subscribe(onNext: {[weak self, weak zeroButton] in
            guard let self = self, let zeroButton = zeroButton else{return}
            self.viewModel.buttonPressed(zeroButton.tag - 1)
        }).disposed(by: disposeBag)
        
        deciButton.height(to: numberPadContainer, multiplier: 0.2)
        deciButton.width(to: numberPadContainer, multiplier: 0.25)
        deciButton.bottomToSuperview()
        deciButton.leftToRight(of: zeroButton)
        
        deciButton.rx.tap.subscribe(onNext: {[weak self, weak deciButton] in
            guard let self = self, let deciButton = deciButton else{return}
            self.viewModel.buttonPressed(deciButton.tag - 1)
        }).disposed(by: disposeBag)
        
        equalButton.height(to: numberPadContainer, multiplier: 0.2)
        equalButton.width(to: numberPadContainer, multiplier: 0.25)
        equalButton.bottomToSuperview()
        equalButton.leftToRight(of: deciButton)
        
        equalButton.rx.tap.subscribe(onNext: {[weak self, weak equalButton] in
            guard let self = self, let equalButton = equalButton else{return}
            self.viewModel.buttonPressed(equalButton.tag - 1)
            self.changeBtnBorder(equalButton.tag)
        }).disposed(by: disposeBag)
        
        oneButton.height(to: numberPadContainer, multiplier: 0.2)
        oneButton.width(to: numberPadContainer, multiplier: 0.25)
        oneButton.bottomToTop(of: zeroButton)
        oneButton.leftToSuperview()
        
        oneButton.rx.tap.subscribe(onNext: {[weak self, weak oneButton] in
            guard let self = self, let oneButton = oneButton else{return}
            self.viewModel.buttonPressed(oneButton.tag - 1)
        }).disposed(by: disposeBag)
        
        twoButton.height(to: numberPadContainer, multiplier: 0.2)
        twoButton.width(to: numberPadContainer, multiplier: 0.25)
        twoButton.bottomToTop(of: zeroButton)
        twoButton.leftToRight(of: oneButton)
        
        twoButton.rx.tap.subscribe(onNext: {[weak self, weak twoButton] in
            guard let self = self, let twoButton = twoButton else{return}
            self.viewModel.buttonPressed(twoButton.tag - 1)
        }).disposed(by: disposeBag)
        
        threeButton.height(to: numberPadContainer, multiplier: 0.2)
        threeButton.width(to: numberPadContainer, multiplier: 0.25)
        threeButton.bottomToTop(of: deciButton)
        threeButton.leftToRight(of: twoButton)
        
        threeButton.rx.tap.subscribe(onNext: {[weak self, weak threeButton] in
            guard let self = self, let threeButton = threeButton else{return}
            self.viewModel.buttonPressed(threeButton.tag - 1)
        }).disposed(by: disposeBag)
        
        plusButton.height(to: numberPadContainer, multiplier: 0.2)
        plusButton.width(to: numberPadContainer, multiplier: 0.25)
        plusButton.bottomToTop(of: equalButton)
        plusButton.leftToRight(of: threeButton)
        
        plusButton.rx.tap.subscribe(onNext: {[weak self, weak plusButton] in
            guard let self = self, let plusButton = plusButton else{return}
            self.viewModel.buttonPressed(plusButton.tag - 1)
            self.changeBtnBorder(plusButton.tag)
        }).disposed(by: disposeBag)
        
        fourButton.height(to: numberPadContainer, multiplier: 0.2)
        fourButton.width(to: numberPadContainer, multiplier: 0.25)
        fourButton.bottomToTop(of: oneButton)
        fourButton.leftToSuperview()
        
        fourButton.rx.tap.subscribe(onNext: {[weak self, weak fourButton] in
            guard let self = self, let fourButton = fourButton else{return}
            self.viewModel.buttonPressed(fourButton.tag - 1)
        }).disposed(by: disposeBag)
        
        fiveButton.height(to: numberPadContainer, multiplier: 0.2)
        fiveButton.width(to: numberPadContainer, multiplier: 0.25)
        fiveButton.bottomToTop(of: twoButton)
        fiveButton.leftToRight(of: fourButton)
        
        fiveButton.rx.tap.subscribe(onNext: {[weak self, weak fiveButton] in
            guard let self = self, let fiveButton = fiveButton else{return}
            self.viewModel.buttonPressed(fiveButton.tag - 1)
        }).disposed(by: disposeBag)
        
        sixButton.height(to: numberPadContainer, multiplier: 0.2)
        sixButton.width(to: numberPadContainer, multiplier: 0.25)
        sixButton.bottomToTop(of: threeButton)
        sixButton.leftToRight(of: fiveButton)
        
        sixButton.rx.tap.subscribe(onNext: {[weak self, weak sixButton] in
            guard let self = self, let sixButton = sixButton else{return}
            self.viewModel.buttonPressed(sixButton.tag - 1)
        }).disposed(by: disposeBag)
        
        minusButton.height(to: numberPadContainer, multiplier: 0.2)
        minusButton.width(to: numberPadContainer, multiplier: 0.25)
        minusButton.bottomToTop(of: plusButton)
        minusButton.leftToRight(of: sixButton)
        
        minusButton.rx.tap.subscribe(onNext: {[weak self, weak minusButton] in
            guard let self = self, let minusButton = minusButton else{return}
            self.viewModel.buttonPressed(minusButton.tag - 1)
            self.changeBtnBorder(minusButton.tag)
        }).disposed(by: disposeBag)
        
        sevenButton.height(to: numberPadContainer, multiplier: 0.2)
        sevenButton.width(to: numberPadContainer, multiplier: 0.25)
        sevenButton.bottomToTop(of: fourButton)
        sevenButton.leftToSuperview()
        
        sevenButton.rx.tap.subscribe(onNext: {[weak self, weak sevenButton] in
            guard let self = self, let sevenButton = sevenButton else{return}
            self.viewModel.buttonPressed(sevenButton.tag - 1)
        }).disposed(by: disposeBag)
        
        eightButton.height(to: numberPadContainer, multiplier: 0.2)
        eightButton.width(to: numberPadContainer, multiplier: 0.25)
        eightButton.bottomToTop(of: fiveButton)
        eightButton.leftToRight(of: sevenButton)
        
        eightButton.rx.tap.subscribe(onNext: {[weak self, weak eightButton] in
            guard let self = self, let eightButton = eightButton else{return}
            self.viewModel.buttonPressed(eightButton.tag - 1)
        }).disposed(by: disposeBag)
        
        nineButton.height(to: numberPadContainer, multiplier: 0.2)
        nineButton.width(to: numberPadContainer, multiplier: 0.25)
        nineButton.bottomToTop(of: sixButton)
        nineButton.leftToRight(of: eightButton)
        
        nineButton.rx.tap.subscribe(onNext: {[weak self, weak nineButton] in
            guard let self = self, let nineButton = nineButton else{return}
            self.viewModel.buttonPressed(nineButton.tag - 1)
        }).disposed(by: disposeBag)
        
        multButton.height(to: numberPadContainer, multiplier: 0.2)
        multButton.width(to: numberPadContainer, multiplier: 0.25)
        multButton.bottomToTop(of: minusButton)
        multButton.leftToRight(of: nineButton)
        
        multButton.rx.tap.subscribe(onNext: {[weak self, weak multButton] in
            guard let self = self, let multButton = multButton else{return}
            self.viewModel.buttonPressed(multButton.tag - 1)
            self.changeBtnBorder(multButton.tag)
        }).disposed(by: disposeBag)
        
        acButton.height(to: numberPadContainer, multiplier: 0.2)
        acButton.width(to: numberPadContainer, multiplier: 0.25)
        acButton.bottomToTop(of: sevenButton)
        acButton.leftToSuperview()
        
        acButton.rx.tap.subscribe(onNext: {[weak self, weak acButton] in
            guard let self = self, let acButton = acButton else{return}
            self.viewModel.buttonPressed(acButton.tag - 1)
            self.changeBtnBorder(acButton.tag)
        }).disposed(by: disposeBag)
        
        posnegButton.height(to: numberPadContainer, multiplier: 0.2)
        posnegButton.width(to: numberPadContainer, multiplier: 0.25)
        posnegButton.bottomToTop(of: eightButton)
        posnegButton.leftToRight(of: acButton)
        
        posnegButton.rx.tap.subscribe(onNext: {[weak self, weak posnegButton] in
            guard let self = self, let posnegButton = posnegButton else{return}
            self.viewModel.buttonPressed(posnegButton.tag - 1)
        }).disposed(by: disposeBag)
        
        percButton.height(to: numberPadContainer, multiplier: 0.2)
        percButton.width(to: numberPadContainer, multiplier: 0.25)
        percButton.bottomToTop(of: nineButton)
        percButton.leftToRight(of: posnegButton)
        
        percButton.rx.tap.subscribe(onNext: {[weak self, weak percButton] in
            guard let self = self, let percButton = percButton else{return}
            self.viewModel.buttonPressed(percButton.tag - 1)
        }).disposed(by: disposeBag)
        
        divideButton.height(to: numberPadContainer, multiplier: 0.2)
        divideButton.width(to: numberPadContainer, multiplier: 0.25)
        divideButton.bottomToTop(of: multButton)
        divideButton.leftToRight(of: percButton)
        
        divideButton.rx.tap.subscribe(onNext: {[weak self, weak divideButton] in
            guard let self = self, let divideButton = divideButton else{return}
            self.viewModel.buttonPressed(divideButton.tag - 1)
            self.changeBtnBorder(divideButton.tag)
        }).disposed(by: disposeBag)
    }
    private func changeBtnBorder (_ value:Int){
        if((value == 12 || value == 17) && prevTag != 0){
            let button = self.view.viewWithTag(prevTag) as! UIButton
            button.layer.borderWidth = 1
            prevTag = 0
        }
        if(value >= 13 && value <= 16){
            if prevTag != 0{
                let button = self.view.viewWithTag(prevTag) as! UIButton
                button.layer.borderWidth = 1
                prevTag = 0
            }
            let button = self.view.viewWithTag(value) as! UIButton
            button.layer.borderWidth = 3
            prevTag = value
        }
    }
    
}

