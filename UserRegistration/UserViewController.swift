//
//  UserViewController.swift
//  UserRegistration
//
//  Created by Екатерина Вишневская - ВТБ on 10.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    var login: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserScreen()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension UserViewController {
    
    func setUserScreen() {
        view.backgroundColor = .white
        
        let safeArea = view.safeAreaLayoutGuide
        
        let loginLabel = UILabel()
        view.addSubview(loginLabel)
        
        loginLabel.text = login
        loginLabel.font = UIFont.boldSystemFont(ofSize: 16)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([loginLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 26), loginLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor), loginLabel.heightAnchor.constraint(equalToConstant: 16), loginLabel.widthAnchor.constraint(equalToConstant: 110)])
        
        let passwordLabel = UILabel()
        view.addSubview(passwordLabel)
        
        passwordLabel.text = password
        passwordLabel.font = UIFont.boldSystemFont(ofSize: 16)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([passwordLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 26), passwordLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor), passwordLabel.heightAnchor.constraint(equalToConstant: 16), passwordLabel.widthAnchor.constraint(equalToConstant: 110)])
        
    }
}
