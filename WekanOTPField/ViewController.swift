//
//  ViewController.swift
//  WekanOTPField
//
//  Created by Brian on 12/08/20.
//  Copyright © 2020 Wekan. All rights reserved.
//

import UIKit
import SVPinView

class ViewController: UIViewController {
    
    @IBOutlet var pinView: SVPinView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePinView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // Setup background gradient
         setGradientBackground(view: self.view, colorTop: .systemBlue, colorBottom: .white)
    }
    
    func configurePinView() {
//        pinView.pinLength = 6
        pinView.secureCharacter = "\u{25CF}"
        pinView.interSpace = 10
        pinView.textColor = UIColor.darkText
        pinView.borderLineColor = UIColor.darkText
        pinView.activeBorderLineColor = UIColor.systemBlue
        pinView.borderLineThickness = 1
        pinView.shouldSecureText = true
        pinView.allowsWhitespaces = false
        pinView.style = .none
        pinView.fieldBackgroundColor = UIColor.white.withAlphaComponent(0.3)
        pinView.activeFieldBackgroundColor = UIColor.white.withAlphaComponent(0.5)
        pinView.fieldCornerRadius = 15
        pinView.activeFieldCornerRadius = 15
        pinView.placeholder = "******"
//        pinView.deleteButtonAction = .deleteCurrentAndMoveToPrevious
//        pinView.keyboardAppearance = .default
        pinView.tintColor = .white
        pinView.becomeFirstResponderAtIndex = 0
        pinView.shouldDismissKeyboardOnEmptyFirstField = false
        
        pinView.font = UIFont.systemFont(ofSize: 15)
        pinView.keyboardType = .phonePad
        pinView.pinInputAccessoryView = { () -> UIView in
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
            doneToolbar.barStyle = UIBarStyle.default
            let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(dismissKeyboard))
            
            var items = [UIBarButtonItem]()
            items.append(flexSpace)
            items.append(done)
            
            doneToolbar.items = items
            doneToolbar.sizeToFit()
            return doneToolbar
        }()
        
        pinView.didFinishCallback = didFinishEnteringPin(pin:)
        pinView.didChangeCallback = { pin in
            print("The entered pin is \(pin)")
        }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
        
    @IBAction func clearPin() {
        pinView.clearPin()
    }
    
    @IBAction func toggleStyle() {
        var nextStyle = pinView.style.rawValue + 1
        if nextStyle == 3 { nextStyle = 0 }
        let style = SVPinViewStyle(rawValue: nextStyle)!
        switch style {
        case .none:
            pinView.fieldBackgroundColor = UIColor.white.withAlphaComponent(0.3)
            pinView.activeFieldBackgroundColor = UIColor.white.withAlphaComponent(0.5)
            pinView.fieldCornerRadius = 15
            pinView.activeFieldCornerRadius = 15
            pinView.style = style
        case .box:
            pinView.activeBorderLineThickness = 4
            pinView.fieldBackgroundColor = UIColor.clear
            pinView.activeFieldBackgroundColor = UIColor.clear
            pinView.fieldCornerRadius = 0
            pinView.activeFieldCornerRadius = 0
            pinView.style = style
        case .underline:
            pinView.activeBorderLineThickness = 4
            pinView.fieldBackgroundColor = UIColor.clear
            pinView.activeFieldBackgroundColor = UIColor.clear
            pinView.fieldCornerRadius = 0
            pinView.activeFieldCornerRadius = 0
            pinView.style = style
        }
        clearPin()
    }
    
    func didFinishEnteringPin(pin:String) {
        print("The Pin entered is \(pin)")
    }
    
    // MARK: Helper Functions
    
    func setGradientBackground(view:UIView, colorTop:UIColor, colorBottom:UIColor) {
        for layer in view.layer.sublayers! {
            if layer.name == "gradientLayer" {
                layer.removeFromSuperlayer()
            }
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        gradientLayer.name = "gradientLayer"
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

