//
//  ViewController.swift
//  UserRegistration
//
//  Created by Екатерина Вишневская - ВТБ on 10.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let loginField = UITextField()
    let passwordField = UITextField()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        if let context = appDelegate?.persistentContainer.viewContext{
            
            guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context)       else { return }
            
            let user = NSManagedObject(entity: entity, insertInto: context)
            let login = user.value(forKey: "login") as? String
            let password = user.value(forKey: "password") as? String
            if let login = login, let password = password {
                goToUserScreen(login: login, password: password)
            } else {
                setRegistrationScreen()
            }
        }
            
    }
    

}

extension ViewController {
    
    func goToUserScreen(login: String, password: String) {
        let controller = UserViewController()
        controller.login = login
        controller.password = password
        self.present(controller, animated:false, completion:nil)
    }
    
    @objc private func createUser() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else { return }
            
            let user = NSManagedObject(entity: entity, insertInto: context)
            guard let login = loginField.text else {
                return
            }
            guard let password = passwordField.text else {
                return
            }
            if login == "", password == "" {
                return
            }
            user.setValue(login, forKey: "login")
            user.setValue(password, forKey: "password")
            
            do {
                try context.save()
            } catch  {
                print("Fail to save")
            }

            goToUserScreen(login: login, password: password)

        }
    }
    
    func setRegistrationScreen() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        let headerLabel = UILabel()
        view.addSubview(headerLabel)
        headerLabel.text = "Регистрация"
        headerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([headerLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 26), headerLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor), headerLabel.heightAnchor.constraint(equalToConstant: 16), headerLabel.widthAnchor.constraint(equalToConstant: 110)])
        
        
        view.addSubview(loginField)
        loginField.translatesAutoresizingMaskIntoConstraints = false
        loginField.keyboardType = UIKeyboardType.emailAddress
        loginField.font = UIFont.systemFont(ofSize: 14)
        loginField.attributedPlaceholder = NSAttributedString(string: "Логин", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0)])
        
               
        view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.font = UIFont.systemFont(ofSize: 14)
        passwordField.attributedPlaceholder = NSAttributedString(string: "Придумайте пароль", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.0)])
        passwordField.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([loginField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16), loginField.widthAnchor.constraint(equalToConstant: 300), loginField.heightAnchor.constraint(equalToConstant: 15), loginField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 37), passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 16), passwordField.widthAnchor.constraint(equalToConstant: 300), passwordField.heightAnchor.constraint(equalToConstant: 15), passwordField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 37)])
        
        let createButton = UIButton()
        view.addSubview(createButton)
         createButton.translatesAutoresizingMaskIntoConstraints = false
         createButton.setAttributedTitle(NSAttributedString(string: "Создать профиль", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)]), for: .normal)
         createButton.layer.cornerRadius = 10
         createButton.backgroundColor = UIColor(red:0.28, green: 0.4, blue: 0.98, alpha: 1.0)
         NSLayoutConstraint.activate([createButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -31), createButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor), createButton.widthAnchor.constraint(equalToConstant: 320),  createButton.heightAnchor.constraint(equalToConstant: 51)])
        createButton.addTarget(self, action: #selector(createUser), for: .touchUpInside)
    }
}
