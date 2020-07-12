//
//  UserViewController.swift
//  UserRegistration
//
//  Created by Екатерина Вишневская - ВТБ on 10.07.2020.
//  Copyright © 2020 Екатерина Вишневская - ВТБ. All rights reserved.
//

import UIKit
import CoreData

class UserViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var login: String = ""
    var password: String = ""
    var name: String = ""
    var surname: String = ""
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
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
    //MARK: - View
    func setUserScreen() {
        view.backgroundColor = .white
        
        let safeArea = view.safeAreaLayoutGuide
        
               let loginLabel = UILabel()
        view.addSubview(loginLabel)
        
        loginLabel.text = login
        loginLabel.font = UIFont.boldSystemFont(ofSize: 16)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([loginLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 26), loginLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor), loginLabel.heightAnchor.constraint(equalToConstant: 16), loginLabel.widthAnchor.constraint(equalToConstant: 110)])
        
        let avatar = UIImageView()
        view.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 37
        avatar.image = UIImage(contentsOfFile: "default_avatar.png")
        avatar.contentMode = .scaleAspectFit
        avatar.clipsToBounds = true
        NSLayoutConstraint.activate([avatar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 26), loginLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10), loginLabel.heightAnchor.constraint(equalToConstant: 16), loginLabel.widthAnchor.constraint(equalToConstant: 110)])
              
        if let context = appDelegate?.persistentContainer.viewContext {
            
            guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context)       else { return }
                
            let user = NSManagedObject(entity: entity, insertInto: context)
            let avatarData = user.value(forKey: "avatar") as? Data
            if let avatarData = avatarData {
                avatar.image = UIImage(data: avatarData)
            }
        }
              
        let nameLabel = UILabel()
        view.addSubview(nameLabel)
        
        nameLabel.text = name + " " + surname
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 26),  nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 10), nameLabel.heightAnchor.constraint(equalToConstant: 16), nameLabel.widthAnchor.constraint(equalToConstant: 110)])
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .photoLibrary
        
        let addCarButton = UIButton()
        view.addSubview(addCarButton)
        addCarButton.translatesAutoresizingMaskIntoConstraints = false
        addCarButton.setImage(.add, for: .normal)
        addCarButton.addTarget(self, action: #selector(addCar), for: .touchUpInside)
        
        let showCarsButton = UIButton()
        view.addSubview(addCarButton)
        showCarsButton.translatesAutoresizingMaskIntoConstraints = false
        showCarsButton.setAttributedTitle(NSAttributedString(string: "Показать машины", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)]), for: .normal)
        showCarsButton.layer.cornerRadius = 10
        showCarsButton.backgroundColor = UIColor(red:0.28, green: 0.4, blue: 0.98, alpha: 1.0)
        NSLayoutConstraint.activate([showCarsButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -31), showCarsButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor), showCarsButton.widthAnchor.constraint(equalToConstant: 320),  showCarsButton.heightAnchor.constraint(equalToConstant: 51)])
        showCarsButton.addTarget(self, action: #selector(showCars), for: .touchUpInside)
        
    }
    
    @objc private func showCars()  {
        let controller = TableViewController()
        self.present(controller, animated:false, completion:nil)
    }
    
    @objc private func addCar() {
        var number = ""
        
        let alert = UIAlertController(title: "Car", message: "Enter a car number", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = "xx111x"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            number = alert?.textFields![0].text as! String
        }))

        self.present(alert, animated: true, completion: nil)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            guard let entity = NSEntityDescription.entity(forEntityName: "Car", in: context) else { return }
            
            let car = NSManagedObject(entity: entity, insertInto: context)

            car.setValue(number, forKey: "number")
            
            do {
                try context.save()
            } catch  {
                print("Fail to save")
            }
        }
    }
}
