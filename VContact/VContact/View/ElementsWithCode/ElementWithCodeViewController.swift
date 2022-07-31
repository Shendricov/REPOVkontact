//
//  ElementWithCodeViewController.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 21.05.2022.
//

import UIKit

class ElementWithCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        // Do any additional setup after loading the view.
    }
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
//        scroll.frame = CGRect(x: 0, y: 0, width: 300, height: 600)
        scroll.backgroundColor = .cyan
        return scroll
    }()

    private let imageLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        image.contentMode = .scaleToFill
        image.image = .init(named: "logoVK-1")
        return image
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = textField.frame.height/2
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.leftViewMode = .whileEditing
        textField.returnKeyType = .done
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = textField.frame.height/2
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.leftViewMode = .whileEditing
        textField.returnKeyType = .done
        return textField
    }()
    
    private let buttonLogin: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle("Login", for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(ElementWithCodeViewController.self, action: #selector(tapButtonLogin), for: .touchUpInside)
        
        return button
    }()
    
    @objc func tapButtonLogin() {
        let newTabController = TBCForElementWithCode()
        newTabController.modalPresentationStyle = .fullScreen
        present(newTabController, animated: true)
    }
}

extension ElementWithCodeViewController {
    private func setupView() {
        scrollView.addSubview(imageLogo)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(buttonLogin)
        scrollView.subviews.forEach({element in
        })
        
        view.addSubview(scrollView)
        view.backgroundColor = UIColor.yellow
        
    }
}


extension ElementWithCodeViewController {
    private func setConstraints () {
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leftAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            imageLogo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            imageLogo.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 1/2),
            imageLogo.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 1/2),
            imageLogo.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameTextField.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 50),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
     
        NSLayoutConstraint.activate([
            buttonLogin.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            buttonLogin.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            buttonLogin.heightAnchor.constraint(equalToConstant: 40),
            buttonLogin.widthAnchor.constraint(equalToConstant: 250)
        ])
        
    }
    
}
