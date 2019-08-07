//
//  ViewController.swift
//  calculator
//
//  Created by Collin Hemeltjen on 28/07/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	#warning("calculating with big numbers doesn't work")
	var firstNumber: Float?
	var secondNumber: Float?
	var operation: Operation?

	@IBOutlet weak var displayLabel: UILabel!
	var shouldOverrideLabelTextOnNextInput = true

	@IBOutlet weak var clearButton: UIButton!

	@IBAction func pressedNumber(_ sender: UIButton) {
		if shouldOverrideLabelTextOnNextInput ||
			displayLabel.text == "0"{
			shouldOverrideLabelTextOnNextInput = false
			displayLabel.text = sender.titleLabel!.text!
		} else {
			displayLabel.text?.append(sender.titleLabel!.text!)
		}

		clearButton.setTitle("c", for: .normal)
	}

	@IBAction func pressedAddition(_ sender: Any) {
		saveCurrentNumber()
		calculateResultIfNeeded()
		operation = .addition
	}

	@IBAction func pressedSubtraction(_ sender: Any) {
		saveCurrentNumber()
		calculateResultIfNeeded()
		operation = .subtraction
	}

	@IBAction func pressedMultiplication(_ sender: Any) {
		saveCurrentNumber()
		calculateResultIfNeeded()
		operation = .multiplication
	}

	@IBAction func pressedDivision(_ sender: Any) {
		saveCurrentNumber()
		calculateResultIfNeeded()
		operation = .division
	}

	@IBAction func pressedResult(_ sender: Any) {
		saveCurrentNumber()
		calculateResultIfNeeded()
	}

	@IBAction func pressedClear(_ sender: Any) {
		if displayLabel.text != "0" {
			displayLabel.text = "0"
			shouldOverrideLabelTextOnNextInput = true
			clearButton.setTitle("ac", for: .normal)
		} else {
			firstNumber = nil
			secondNumber = nil
			operation = nil

			displayLabel.text = "0"
			shouldOverrideLabelTextOnNextInput = true
		}
	}

	@IBAction func pressedDot(_ sender: UIButton) {
		displayLabel.text?.append(sender.titleLabel!.text!)
		shouldOverrideLabelTextOnNextInput = false
	}

	func saveCurrentNumber(){
		if !shouldOverrideLabelTextOnNextInput{
			if firstNumber == nil || operation == nil {
				firstNumber = Float(displayLabel.text!)
			} else {
				secondNumber = Float(displayLabel.text!)
			}

			shouldOverrideLabelTextOnNextInput.toggle()
		}
	}

	func calculateResultIfNeeded(){
		if firstNumber != nil &&
			secondNumber != nil &&
			operation != nil {

			var result: Float = 0

			switch operation! {
			case .addition:
				result = firstNumber! + secondNumber!
			case .subtraction:
				result = firstNumber! - secondNumber!
			case .multiplication:
				result = firstNumber! * secondNumber!
			case .division:
				result = firstNumber! / secondNumber!
			}

			firstNumber = result
			secondNumber = nil
			operation = nil

			showNumber(firstNumber!)
		}
	}

	func showNumber(_ number: Float){
		if Float(Int(number)) == number {
			displayLabel.text = String(describing: Int(number))
		} else {
			displayLabel.text = String(describing: number)
		}
	}

	override func viewDidLoad() {
		displayLabel.adjustsFontSizeToFitWidth = true
		displayLabel.baselineAdjustment = .alignCenters
	}
}

enum Operation {
	case addition
	case subtraction
	case multiplication
	case division
}
