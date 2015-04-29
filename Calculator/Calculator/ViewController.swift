//
//  ViewController.swift
//  Calculator
//
//  Created by Nicolas Dubus on 2015-02-19.
//  Copyright (c) 2015 WorldDubination. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTypingANumber = false
    var hasDot = false
    
    var brain = CalculatorBrain()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            if digit == "." {
                if !hasDot {
                    hasDot = true
                    display.text = display.text! + "."
                }
            } else if digit == "PI" {
                if userIsInTheMiddleOfTypingANumber {
                    enter()
                }
                display.text = "3.14159265359"
            } else if digit == "C" {
                userIsInTheMiddleOfTypingANumber = false
                displayValue = 0
            } else {
                display.text = display.text! + digit
            }
        } else {
            if digit == "PI" {
                    enter()
                display.text = "3.14159265359"
            } else if digit == "C" {
                displayValue = 0
            } else {
            display.text = digit
            }
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        hasDot = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }

    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
           display.text = "\(newValue)"
           userIsInTheMiddleOfTypingANumber = false
        }
        
    }
}

