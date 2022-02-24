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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setTopLabel()
        setupNumberPad()
    }
    
    private var resultLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 50)
        return label
    }()
    
    private func setTopLabel(){
        let label = UILabel(frame: CGRect(x:0,
                                          y:0,
                                          width:view.frame.width,
                                          height:150))
        
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.black
        label.text = "Dynamic Calculator"
        label.font = UIFont(name:"Helvetica-Bold", size: 24.0)
        label.textColor = UIColor.white
        self.view.addSubview(label)
    }
    
    private func setupNumberPad(){
        let buttonSize:CGFloat = view.frame.size.width / 4;
        let zeroButton = UIButton(frame: CGRect(x:0,
                                                y:view.frame.size.height-buttonSize,
                                                width: buttonSize * 2,
                                                height:buttonSize))
        zeroButton.setTitle("0", for: .normal)
        zeroButton.layer.borderWidth = 1
        zeroButton.layer.borderColor = UIColor.black.cgColor
        zeroButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        zeroButton.setTitleColor(.black, for: .normal)
        zeroButton.backgroundColor = UIColor.lightGray
        self.view.addSubview(zeroButton)
        zeroButton.tag = 1
        zeroButton.rx.tap.subscribe(onNext: {[weak self, weak zeroButton] in
            guard let self = self, let zeroButton = zeroButton else{return}
            self.viewModel.buttonPressed(zeroButton.tag - 1)
        }).disposed(by: disposeBag)
        
        let deciButton = UIButton(frame: CGRect(x:buttonSize * 2,
                                                y:view.frame.size.height-buttonSize,
                                                width: buttonSize,
                                                height:buttonSize))
        deciButton.setTitle(".", for: .normal)
        deciButton.layer.borderWidth = 1
        deciButton.layer.borderColor = UIColor.black.cgColor
        deciButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
        deciButton.setTitleColor(.black, for: .normal)
        deciButton.backgroundColor = UIColor.lightGray
        self.view.addSubview(deciButton)
        deciButton.tag = 11
        deciButton.rx.tap.subscribe(onNext: {[weak self, weak deciButton] in
            guard let self = self, let deciButton = deciButton else{return}
            self.viewModel.buttonPressed(deciButton.tag - 1)
        }).disposed(by: disposeBag)
        
        for x in 0..<3{
            let button_row1 = UIButton(frame: CGRect(x:(buttonSize * CGFloat(x)),
                                                     y:view.frame.size.height-(buttonSize*2),
                                                     width: buttonSize,
                                                     height:buttonSize))
            button_row1.setTitle("\(x+1)", for: .normal)
            button_row1.layer.borderWidth = 1
            button_row1.layer.borderColor = UIColor.black.cgColor
            button_row1.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
            button_row1.setTitleColor(.black, for: .normal)
            button_row1.backgroundColor = UIColor.lightGray
            self.view.addSubview(button_row1)
            button_row1.tag = x + 2;
            button_row1.rx.tap.subscribe(onNext: {[weak self, weak button_row1] in
                guard let self = self, let button_row1 = button_row1 else{return}
                self.viewModel.buttonPressed(button_row1.tag - 1)
            }).disposed(by: disposeBag)
        }
        for x in 0..<3{
            let button_row2 = UIButton(frame: CGRect(x:(buttonSize * CGFloat(x)),
                                                     y:view.frame.size.height-(buttonSize*3),
                                                     width: buttonSize,
                                                     height:buttonSize))
            button_row2.setTitle("\(x+4)", for: .normal)
            button_row2.layer.borderWidth = 1
            button_row2.layer.borderColor = UIColor.black.cgColor
            button_row2.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
            button_row2.setTitleColor(.black, for: .normal)
            button_row2.backgroundColor = UIColor.lightGray
            self.view.addSubview(button_row2)
            button_row2.tag = x + 5
            
            button_row2.rx.tap.subscribe(onNext: {[weak self, weak button_row2] in
                guard let self = self, let button_row2 = button_row2 else{return}
                self.viewModel.buttonPressed(button_row2.tag - 1)
            }).disposed(by: disposeBag)
        }
        for x in 0..<3{
            let button_row3 = UIButton(frame: CGRect(x:(buttonSize * CGFloat(x)),
                                                     y:view.frame.size.height-(buttonSize*4),
                                                     width: buttonSize,
                                                     height:buttonSize))
            button_row3.setTitle("\(x+7)", for: .normal)
            button_row3.layer.borderWidth = 1
            button_row3.layer.borderColor = UIColor.black.cgColor
            button_row3.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
            button_row3.setTitleColor(.black, for: .normal)
            button_row3.backgroundColor = UIColor.lightGray
            self.view.addSubview(button_row3)
            button_row3.tag = x + 8
            button_row3.rx.tap.subscribe(onNext: {[weak self, weak button_row3] in
                guard let self = self, let button_row3 = button_row3 else{return}
                self.viewModel.buttonPressed(button_row3.tag - 1)
            }).disposed(by: disposeBag)
        }
        
        let operations = ["=", "+", "-", "x", "/"]
        for x in 0..<5{
            let operators = UIButton(frame: CGRect(x:(buttonSize * 3),
                                                   y:view.frame.size.height-(buttonSize * CGFloat(x+1)),
                                                   width: buttonSize,
                                                   height:buttonSize))
            operators.setTitle(operations[x], for: .normal)
            operators.layer.borderWidth = 1
            operators.layer.borderColor = UIColor.black.cgColor
            operators.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
            operators.setTitleColor(.black, for: .normal)
            operators.backgroundColor = UIColor.orange
            self.view.addSubview(operators)
            operators.tag = x + 12;
            operators.rx.tap.subscribe(onNext: {[weak self, weak operators] in
                guard let self = self, let operators = operators else{return}
                self.viewModel.buttonPressed(operators.tag - 1)
                self.changeBtnBorder(operators.tag)
            }).disposed(by: disposeBag)
        }
        
        let top_row = ["AC", "+/-", "%"]
        for x in 0..<3{
            let button_row4 = UIButton(frame: CGRect(x:(buttonSize * CGFloat(x)),
                                                     y:view.frame.size.height-buttonSize*5,
                                                     width: buttonSize,
                                                     height:buttonSize))
            button_row4.setTitle(top_row[x], for: .normal)
            button_row4.layer.borderWidth = 1
            button_row4.layer.borderColor = UIColor.black.cgColor
            button_row4.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 24)
            button_row4.setTitleColor(.white, for: .normal)
            button_row4.backgroundColor = UIColor.darkGray
            self.view.addSubview(button_row4)
            button_row4.tag = x + 17;
            button_row4.rx.tap.subscribe(onNext: {[weak self, weak button_row4] in
                guard let self = self, let button_row4 = button_row4 else{return}
                self.viewModel.buttonPressed(button_row4.tag - 1)
                self.changeBtnBorder(button_row4.tag)
            }).disposed(by: disposeBag)
            
            
            resultLabel.frame = CGRect(x: -10,
                                       y: button_row4.frame.origin.y - 100.0,
                                       width: view.frame.size.width,
                                       height: 100)
            
            self.view.addSubview(resultLabel)
        }
    }
    
    func changeBtnBorder (_ value:Int){
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


