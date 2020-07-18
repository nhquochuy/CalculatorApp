//
//  ViewController.swift
//  Calculator
//
//  Created by Quoc Huy on 7/13/20.
//  Copyright © 2020 Quoc Huy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    deinit {
        print("deinit ViewController")
    }
    
    // MARK: Variable
    var firstNumber: String = ""
    var secondNumber: String = ""
    var equalNUmber: String = ""
    var calculationType: String = ""
    
    // MARK: Outlet
    @IBOutlet weak var resultLabel: UILabel!
    
    
    // MARK: Action
    @IBAction func numberButtonAction(_ sender: UIButton) {
        guard let titleButton = sender.titleLabel?.text
            else { return }
        
        self.doNumber(numberText: titleButton)
    }
    
    @IBAction func calculationButtonAction(_ sender: UIButton) {
        guard let titleButton = sender.titleLabel?.text
            else { return }
        
        self.doCalculationType(calcTypeText: titleButton)
    }
    
    @IBAction func equalButtonAction(_ sender: UIButton) {
        self.doEqual()
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        self.doReset()
    }
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.adjustsFontSizeToFitWidth = true
    }
    
    // MARK: Funtion
    private func doNumber(numberText: String) {
        if self.calculationType == "" {
            self.firstNumber += numberText
        }
        else {
            self.secondNumber += numberText
        }
        self.doResult()
    }
    
    private func doCalculationType(calcTypeText: String) {
        if self.secondNumber == "" {
            self.calculationType = calcTypeText
            self.doResult()
        }
        else
        {
            self.doAlert()
        }
    }
    
    private func doEqual() {
        if self.calculationType != "" {
            var equalNub: Double = 0
            guard let firstNub = Double(self.firstNumber) else { return }
            guard let secondNub = Double(self.secondNumber) else { return }
            
            switch  self.calculationType {
            case "+":
                equalNub = firstNub + secondNub
            case "-":
                equalNub = firstNub - secondNub
            case "x":
                equalNub = firstNub * secondNub
            default:
                equalNub = firstNub / secondNub
            }
            
            self.equalNUmber = (equalNub.isNaN || equalNub.isInfinite) ? "ERROR" : equalNub.clean
            self.doResult()
        }
    }
    
    private func doResult() {
        if equalNUmber == ""  {
            self.firstNumber = self.firstNumber == "" ? "0" : self.firstNumber
            self.resultLabel.text =  self.firstNumber + " " + self.calculationType + " " + self.secondNumber
        } else {
            if self.equalNUmber != "ERROR" {
                self.resultLabel.text =  "= " + self.equalNUmber
                self.firstNumber = self.equalNUmber
                self.secondNumber = ""
                self.equalNUmber = ""
            } else {
                self.resultLabel.text = self.equalNUmber
                self.doRefreshVariable()
            }
            
        }
    }
    
    private func doReset() {
        doRefreshVariable()
        self.resultLabel.text = "0"
    }
    
    private func doRefreshVariable() {
        self.firstNumber = ""
        self.secondNumber = ""
        self.calculationType = ""
        self.equalNUmber = ""
    }
    
    private func doAlert() {
        let alert: UIAlertController = .init(title: "Error", message: "Sorry, Can not perform your action. You need to finish current calculation", preferredStyle: .alert)
        let alertAction: UIAlertAction = .init(title: "OK", style: .destructive, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

