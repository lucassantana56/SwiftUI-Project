//
//  LoginViewController.swift
//  mywords
//
//  Created by Lucas Santana on 30/01/2021.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginErrorDescriptionLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupButton()
    }
    
    
    //MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {

    }
    
    
    func setupButton() {
        loginButton.layer.cornerRadius = 5
    }
    
    
    func setDelegates() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
}

//MARK: - Text Field Delegate Methods
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginErrorDescriptionLabel.isHidden = true
        usernameTextField.layer.borderWidth = 0
        passwordTextField.layer.borderWidth = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
