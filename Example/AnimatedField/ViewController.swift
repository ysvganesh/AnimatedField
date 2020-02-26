//
//  ViewController.swift
//  AnimatedField
//
//  Created by alberdev on 04/03/2019.
//  Copyright (c) 2019 alberdev. All rights reserved.
//

import UIKit
import AnimatedField

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var emailAnimatedField: AnimatedField!
    @IBOutlet weak var usernameAnimatedField: AnimatedField!
    @IBOutlet weak var birthdateAnimatedField: AnimatedField!
    @IBOutlet weak var passwordAnimatedField: AnimatedField!
    @IBOutlet weak var password2AnimatedField: AnimatedField!
    @IBOutlet weak var priceAnimatedField: AnimatedField!
    @IBOutlet weak var urlAnimatedField: AnimatedField!
    @IBOutlet weak var numberAnimatedField: AnimatedField!
    @IBOutlet weak var multilineAnimatedField: AnimatedField!
    @IBOutlet weak var defaultField: AnimatedField!
    @IBOutlet weak var multilineHeightConstraint: NSLayoutConstraint!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTap()
        continueButton.layer.cornerRadius = 5
        
        var format = AnimatedFieldFormat()
        format.titleFont = UIFont(name: "AvenirNext-Regular", size: 10)!
        format.textFont = UIFont(name: "AvenirNext-Regular", size: 16)!
        //format.uppercasedTitles = true
        format.alertColor = .red
        format.alertFieldActive = false
        format.titleAlwaysVisible = false
        format.titleInVisibleIfFilled = false
        format.alertFont = UIFont(name: "AvenirNext-Regular", size: 14)!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          self.usernameAnimatedField.text = ""
        }
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          self.multilineAnimatedField.text = "Write your email Write your email Write your email Write your email Write your email"
        }
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          self.multilineAnimatedField.text = ""
        }
      
        emailAnimatedField.format = format
        emailAnimatedField.setUp(with: .email,
                                 delegate: self,
                                 dataSource: self,
                                 placeHolder: "Write your email",
                                 attributes: [
                                  .foregroundColor: UIColor.red,
                                  .font: UIFont.systemFont(ofSize: 14)])
        emailAnimatedField.tag = 0
        
        usernameAnimatedField.format = format
        usernameAnimatedField.setUp(with: .username(4, 10),
                                    delegate: self,
                                    dataSource: self,
                                    placeHolder: "Write your username",
                                    attributes: nil)
        usernameAnimatedField.tag = 1
        
        birthdateAnimatedField.format = format
        let defaultDate = Date().addingTimeInterval(-20 * 365 * 24 * 60 * 60)
        let minDate = Date().addingTimeInterval(-90 * 365 * 24 * 60 * 60)
        let maxDate = Date().addingTimeInterval(-13 * 365 * 24 * 60 * 60)
        let chooseText = "Choose"
        let dateFormat = "dd / MM / yyyy"
        birthdateAnimatedField.setUp(with: .datepicker(.dateAndTime, defaultDate, minDate, maxDate, chooseText, dateFormat),
                                     delegate: self,
                                     dataSource: self,
                                     placeHolder: "Select your birthday",
                                     attributes: nil)
        birthdateAnimatedField.tag = 2
    
        numberAnimatedField.format = format
        numberAnimatedField.setUp(with: .numberpicker(19, 16, 100, chooseText),
                                  delegate: self,
                                  dataSource: self,
                                  placeHolder: "Select your age",
                                  attributes: nil)
        numberAnimatedField.tag = 3
        
        passwordAnimatedField.format = format
        passwordAnimatedField.setUp(with: .password(6, 10),
                                    delegate: self,
                                    dataSource: self,
                                    placeHolder: "New password (min 6, max 10)",
                                    attributes: nil)
        passwordAnimatedField.isSecure = true
        passwordAnimatedField.disablePasswordAutoFill = true
        passwordAnimatedField.showVisibleButton = true
        passwordAnimatedField.visibleEyeIconApperance = (color: .red, size: .init(width: 15, height: 15))
        passwordAnimatedField.tag = 4
        
        password2AnimatedField.format = format
        password2AnimatedField.setUp(with: .password(6, 10),
                                     delegate: self,
                                     dataSource: self,
                                     placeHolder: "Repeat password",
                                     attributes: nil)
        password2AnimatedField.isSecure = true
        password2AnimatedField.tag = 5
        
        priceAnimatedField.format = format
        priceAnimatedField.setUp(with: .price(100, 2),
                                 delegate: self,
                                 dataSource: self,
                                 placeHolder: "Write the price",
                                 attributes: nil)
        priceAnimatedField.tag = 6
        
        urlAnimatedField.format = format
        urlAnimatedField.setUp(with: .url,
                               delegate: self,
                               dataSource: self,
                               placeHolder: "Write your url web",
                               attributes: nil)
        urlAnimatedField.tag = 7
        
        multilineAnimatedField.format = format
        multilineAnimatedField.format.counterEnabled = true
        multilineAnimatedField.format.countDownDecrementally = false
        multilineAnimatedField.setUp(with: .multiline(70.0),
                                     delegate: self,
                                     dataSource: self,
                                     placeHolder: "Place",
                                     attributes: nil)
        //multilineAnimatedField.autocapitalizationType = .words
        multilineAnimatedField.tag = 8
      
      
        defaultField.format = format
        defaultField.setUp(with: .none,
                           delegate: self,
                           dataSource: self,
                           placeHolder: "This is a no-type field",
                           attributes: nil)
        defaultField.isSecure = true
        defaultField.tag = 9
    }
    
    @IBAction func didPressContinueButton(_ sender: UIButton) {
        print("Can continue")
    }
}


extension ViewController: AnimatedFieldDelegate {
    
    func animatedFieldDidBeginEditing(_ animatedField: AnimatedField) {
        let offset = animatedField.frame.origin.y + animatedField.frame.size.height - (view.frame.height - 350)
        scrollView.setContentOffset(CGPoint(x: 0, y: offset < 0 ? 0 : offset), animated: true)
    }
    
    func animatedFieldDidEndEditing(_ animatedField: AnimatedField) {
        var offset: CGFloat = 0
        if animatedField.frame.origin.y + animatedField.frame.size.height > scrollView.frame.height {
            offset = animatedField.frame.origin.y + animatedField.frame.size.height - scrollView.frame.height + 10
        }
        scrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        
        let validEmailUser = emailAnimatedField.isValid && usernameAnimatedField.isValid
        continueButton.isEnabled = validEmailUser
        continueButton.alpha = validEmailUser ? 1.0 : 0.3
    }
    
    func animatedField(_ animatedField: AnimatedField, didResizeHeight height: CGFloat) {
        multilineHeightConstraint.constant = height
        view.layoutIfNeeded()
        
        let offset = animatedField.frame.origin.y + height - (view.frame.height - 350)
        scrollView.setContentOffset(CGPoint(x: 0, y: offset < 0 ? 0 : offset), animated: false)
    }
    
    func animatedField(_ animatedField: AnimatedField, didSecureText secure: Bool) {
        if animatedField == passwordAnimatedField {
            password2AnimatedField.secureField(secure)
        }
    }
    
    func animatedField(_ animatedField: AnimatedField, didChangePickerValue value: String) {
        numberAnimatedField.text = value
    }
}

extension ViewController: AnimatedFieldDataSource {
    
    func animatedFieldLimit(_ animatedField: AnimatedField) -> Int? {
        switch animatedField.tag {
        case 1: return 10
        case 8: return 30
        default: return nil
        }
    }
    
    func animatedFieldValidationError(_ animatedField: AnimatedField) -> String? {
        if animatedField == emailAnimatedField {
            return "Email invalid! Please check again ;)"
        }
        return nil
    }
}

