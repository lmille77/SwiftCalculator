//
//  ViewController.swift
//  DynamicCalculator
//
//  Created by Logan Miller on 2/18/22.
//
import RxCocoa
import RxSwift
import RxGesture
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
        view.addSubview(oneButton)
        setupLayout()
    }
    
    private func setupLayout(){
        
        
        
        let labelContainer = UIView()
        view.addSubview(labelContainer)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        labelContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        labelContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40).isActive = true
        labelContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        labelContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        labelContainer.addSubview(topLabel)
        labelContainer.addSubview(resultLabel)
        
        topLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topLabel.heightAnchor.constraint(equalTo: labelContainer.heightAnchor, multiplier: 0.4).isActive = true
        
        let numPadding = UIView()
        view.addSubview(numPadding)
        numPadding.translatesAutoresizingMaskIntoConstraints = false
        numPadding.topAnchor.constraint(equalTo: topLabel.bottomAnchor).isActive = true
        numPadding.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        numPadding.widthAnchor.constraint(equalTo: labelContainer.widthAnchor, multiplier: 0.02).isActive = true
        
        resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        resultLabel.trailingAnchor.constraint(equalTo: numPadding.leadingAnchor).isActive = true
        resultLabel.bottomAnchor.constraint(equalTo: labelContainer.bottomAnchor).isActive = true
        
        let numberPadContainer = UIView()
        view.addSubview(numberPadContainer)
        numberPadContainer.translatesAutoresizingMaskIntoConstraints = false
        numberPadContainer.topAnchor.constraint(equalTo: labelContainer.bottomAnchor).isActive = true
        numberPadContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.60).isActive = true
        numberPadContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        numberPadContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        numberPadContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        numberPadContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
      
        zeroButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        zeroButton.bottomAnchor.constraint(equalTo: numberPadContainer.bottomAnchor).isActive = true
        zeroButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.50).isActive = true
        
        zeroButton.rx.tap.subscribe(onNext: {[weak self, weak zeroButton] in
            guard let self = self, let zeroButton = zeroButton else{return}
            self.viewModel.buttonPressed(zeroButton.tag - 1)
        }).disposed(by: disposeBag)
        
        deciButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        deciButton.bottomAnchor.constraint(equalTo: numberPadContainer.bottomAnchor).isActive = true
        deciButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        deciButton.leadingAnchor.constraint(equalTo: zeroButton.trailingAnchor).isActive = true
        
        deciButton.rx.tap.subscribe(onNext: {[weak self, weak deciButton] in
            guard let self = self, let deciButton = deciButton else{return}
            self.viewModel.buttonPressed(deciButton.tag - 1)
        }).disposed(by: disposeBag)
        
        equalButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        equalButton.bottomAnchor.constraint(equalTo: numberPadContainer.bottomAnchor).isActive = true
        equalButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        equalButton.leadingAnchor.constraint(equalTo: deciButton.trailingAnchor).isActive = true

        equalButton.rx.tap.subscribe(onNext: {[weak self, weak equalButton] in
            guard let self = self, let equalButton = equalButton else{return}
            self.viewModel.buttonPressed(equalButton.tag - 1)
        }).disposed(by: disposeBag)
        
        oneButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        oneButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        oneButton.bottomAnchor.constraint(equalTo: zeroButton.topAnchor).isActive = true
        oneButton.leadingAnchor.constraint(equalTo: numberPadContainer.leadingAnchor).isActive = true

        oneButton.rx.tap.subscribe(onNext: {[weak self, weak oneButton] in
            guard let self = self, let oneButton = oneButton else{return}
            self.viewModel.buttonPressed(oneButton.tag - 1)
        }).disposed(by: disposeBag)
        
        twoButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        twoButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        twoButton.bottomAnchor.constraint(equalTo: zeroButton.topAnchor).isActive = true
        twoButton.leadingAnchor.constraint(equalTo: oneButton.trailingAnchor).isActive = true

        twoButton.rx.tap.subscribe(onNext: {[weak self, weak twoButton] in
            guard let self = self, let twoButton = twoButton else{return}
            self.viewModel.buttonPressed(twoButton.tag - 1)
        }).disposed(by: disposeBag)
        
        threeButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        threeButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        threeButton.bottomAnchor.constraint(equalTo: deciButton.topAnchor).isActive = true
        threeButton.leadingAnchor.constraint(equalTo: twoButton.trailingAnchor).isActive = true

        threeButton.rx.tap.subscribe(onNext: {[weak self, weak threeButton] in
            guard let self = self, let threeButton = threeButton else{return}
            self.viewModel.buttonPressed(threeButton.tag - 1)
        }).disposed(by: disposeBag)
        
        plusButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        plusButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: equalButton.topAnchor).isActive = true
        plusButton.leadingAnchor.constraint(equalTo: threeButton.trailingAnchor).isActive = true

        plusButton.rx.tap.subscribe(onNext: {[weak self, weak plusButton] in
            guard let self = self, let plusButton = plusButton else{return}
            self.viewModel.buttonPressed(plusButton.tag - 1)
        }).disposed(by: disposeBag)
        
        fourButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        fourButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        fourButton.bottomAnchor.constraint(equalTo: oneButton.topAnchor).isActive = true
        fourButton.leadingAnchor.constraint(equalTo: numberPadContainer.leadingAnchor).isActive = true

        fourButton.rx.tap.subscribe(onNext: {[weak self, weak fourButton] in
            guard let self = self, let fourButton = fourButton else{return}
            self.viewModel.buttonPressed(fourButton.tag - 1)
        }).disposed(by: disposeBag)
        
        fiveButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        fiveButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        fiveButton.bottomAnchor.constraint(equalTo: twoButton.topAnchor).isActive = true
        fiveButton.leadingAnchor.constraint(equalTo: fourButton.trailingAnchor).isActive = true

        fiveButton.rx.tap.subscribe(onNext: {[weak self, weak fiveButton] in
            guard let self = self, let fiveButton = fiveButton else{return}
            self.viewModel.buttonPressed(fiveButton.tag - 1)
        }).disposed(by: disposeBag)
        
        sixButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        sixButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        sixButton.bottomAnchor.constraint(equalTo: threeButton.topAnchor).isActive = true
        sixButton.leadingAnchor.constraint(equalTo: fiveButton.trailingAnchor).isActive = true

        sixButton.rx.tap.subscribe(onNext: {[weak self, weak sixButton] in
            guard let self = self, let sixButton = sixButton else{return}
            self.viewModel.buttonPressed(sixButton.tag - 1)
        }).disposed(by: disposeBag)
        
        minusButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        minusButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        minusButton.bottomAnchor.constraint(equalTo: plusButton.topAnchor).isActive = true
        minusButton.leadingAnchor.constraint(equalTo: sixButton.trailingAnchor).isActive = true

        minusButton.rx.tap.subscribe(onNext: {[weak self, weak minusButton] in
            guard let self = self, let minusButton = minusButton else{return}
            self.viewModel.buttonPressed(minusButton.tag - 1)
        }).disposed(by: disposeBag)
        
        sevenButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        sevenButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        sevenButton.bottomAnchor.constraint(equalTo: fourButton.topAnchor).isActive = true
        sevenButton.leadingAnchor.constraint(equalTo: numberPadContainer.leadingAnchor).isActive = true

        sevenButton.rx.tap.subscribe(onNext: {[weak self, weak sevenButton] in
            guard let self = self, let sevenButton = sevenButton else{return}
            self.viewModel.buttonPressed(sevenButton.tag - 1)
        }).disposed(by: disposeBag)
        
        eightButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        eightButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        eightButton.bottomAnchor.constraint(equalTo: fiveButton.topAnchor).isActive = true
        eightButton.leadingAnchor.constraint(equalTo: sevenButton.trailingAnchor).isActive = true

        eightButton.rx.tap.subscribe(onNext: {[weak self, weak eightButton] in
            guard let self = self, let eightButton = eightButton else{return}
            self.viewModel.buttonPressed(eightButton.tag - 1)
        }).disposed(by: disposeBag)
        
        nineButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        nineButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        nineButton.bottomAnchor.constraint(equalTo: sixButton.topAnchor).isActive = true
        nineButton.leadingAnchor.constraint(equalTo: eightButton.trailingAnchor).isActive = true

        nineButton.rx.tap.subscribe(onNext: {[weak self, weak nineButton] in
            guard let self = self, let nineButton = nineButton else{return}
            self.viewModel.buttonPressed(nineButton.tag - 1)
        }).disposed(by: disposeBag)
        
        multButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        multButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        multButton.bottomAnchor.constraint(equalTo: minusButton.topAnchor).isActive = true
        multButton.leadingAnchor.constraint(equalTo: nineButton.trailingAnchor).isActive = true

        multButton.rx.tap.subscribe(onNext: {[weak self, weak multButton] in
            guard let self = self, let multButton = multButton else{return}
            self.viewModel.buttonPressed(multButton.tag - 1)
        }).disposed(by: disposeBag)
        
        acButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        acButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        acButton.bottomAnchor.constraint(equalTo: sevenButton.topAnchor).isActive = true
        acButton.leadingAnchor.constraint(equalTo: numberPadContainer.leadingAnchor).isActive = true

        acButton.rx.tap.subscribe(onNext: {[weak self, weak acButton] in
            guard let self = self, let acButton = acButton else{return}
            self.viewModel.buttonPressed(acButton.tag - 1)
        }).disposed(by: disposeBag)
        
        posnegButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        posnegButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        posnegButton.bottomAnchor.constraint(equalTo: eightButton.topAnchor).isActive = true
        posnegButton.leadingAnchor.constraint(equalTo: acButton.trailingAnchor).isActive = true

        posnegButton.rx.tap.subscribe(onNext: {[weak self, weak posnegButton] in
            guard let self = self, let posnegButton = posnegButton else{return}
            self.viewModel.buttonPressed(posnegButton.tag - 1)
        }).disposed(by: disposeBag)
        
        percButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        percButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        percButton.bottomAnchor.constraint(equalTo: nineButton.topAnchor).isActive = true
        percButton.leadingAnchor.constraint(equalTo: posnegButton.trailingAnchor).isActive = true

        percButton.rx.tap.subscribe(onNext: {[weak self, weak percButton] in
            guard let self = self, let percButton = percButton else{return}
            self.viewModel.buttonPressed(percButton.tag - 1)
        }).disposed(by: disposeBag)
        
        divideButton.heightAnchor.constraint(equalTo: numberPadContainer.heightAnchor, multiplier: 0.2).isActive = true
        divideButton.widthAnchor.constraint(equalTo: numberPadContainer.widthAnchor, multiplier: 0.25).isActive = true
        divideButton.bottomAnchor.constraint(equalTo: multButton.topAnchor).isActive = true
        divideButton.leadingAnchor.constraint(equalTo: percButton.trailingAnchor).isActive = true

        divideButton.rx.tap.subscribe(onNext: {[weak self, weak divideButton] in
            guard let self = self, let divideButton = divideButton else{return}
            self.viewModel.buttonPressed(divideButton.tag - 1)
        }).disposed(by: disposeBag)
    }
}
    
