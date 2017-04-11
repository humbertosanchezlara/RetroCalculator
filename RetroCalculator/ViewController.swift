//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Humberto Sanchez Lara on 11/11/16.
//  Copyright © 2016 Humberto Sanchez. All rights reserved.
//

import UIKit

import AVFoundation

class ViewController: UIViewController {

    var btnSound: AVAudioPlayer!
    
    var runningNumber = "0"
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = ""
        
    }
    
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    @IBOutlet weak var outputLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let path = Bundle.main.path(forResource: "btn", ofType: "wav")
         let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        print("HSLRight: \(rightValStr)")
        print("HSLOperator: \(currentOperation)")
        print("HSLRunning: \(runningNumber)")
        print("HSLLeft: \(leftValStr)")
        print("HSL============================")
    }
    
    @IBAction func  onDividePressed(sender: AnyObject){
        processOperation(operation: .Divide)
    }
    
    @IBAction func  onMultiplyPressed(sender: AnyObject){
        processOperation(operation: .Multiply)
    }
    
    @IBAction func  onSubtractPressed(sender: AnyObject){
        processOperation(operation: .Subtract)
    }
    
    @IBAction func  onAddPressed(sender: AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func  onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation )
        currentOperation = Operation.Empty
    }

    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        playSound()
     
            if leftValStr != "" && currentOperation != Operation.Empty{
                // A user selected an operator but then selected another opeator without first entering a number
                if runningNumber != "" {
                    rightValStr = runningNumber
                    runningNumber = ""
                    print("HSLRight: \(rightValStr)")
                    print("HSLOperator: \(operation)")
                    print("HSLRunning: \(runningNumber)")
                    print("HSLLeft: \(leftValStr)")
                    print("HSL============================")
             
                    if currentOperation == Operation.Multiply {
                        result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    } else if currentOperation == Operation.Divide {
                        result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                    } else if currentOperation == Operation.Subtract {
                        result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                    } else if currentOperation == Operation.Add {
                        result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    }
                    
                    leftValStr = result
                    outputLbl.text = result
                    
                }
                
                    currentOperation = operation
                    
                    print("HSLRight: \(rightValStr)")
                    print("HSLOperator: \(operation)")
                    print("HSLRunning: \(runningNumber)")
                    print("HSLLeft: \(leftValStr)")
                    print("HSLResult: \(result)")
                    print("HSL============================")
                   
                    } else {
                // This is the first time an operator has been pressed
                leftValStr = runningNumber
                runningNumber = ""
                currentOperation = operation
                print("HSLRight: \(rightValStr)")
                print("HSLOperator: \(operation)")
                print("HSLRunning: \(runningNumber)")
                print("HSLLeft: \(leftValStr)")
                print("HSLResult: \(result)")
                print("HSL============================")
            }
        }
    }

