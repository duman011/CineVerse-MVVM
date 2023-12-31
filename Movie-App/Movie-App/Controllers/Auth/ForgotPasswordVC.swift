//
//  ForgotPasswordVC.swift
//  Movie-App
//
//  Created by Yaşar Duman on 18.10.2023.
//

import UIKit

final class ForgotPasswordVC: UIViewController {
    // MARK: - Properties
    private let HeadLabel            = TitleLabel(textAlignment: .left, fontSize: 20)
    private lazy var emailTextField       = CustomTextField(fieldType: .email)
    private lazy var forgotPasswordButton = MovieButton( bgColor:MovieColor.playButonBG ,color:MovieColor.playButonBG, title: "Submit", fontSize: .big)
    private let infoLabel            = SecondaryTitleLabel(fontSize: 16)
    private lazy var signInButton         = MovieButton( bgColor:.clear ,color: .label, title: "Sign In.", fontSize: .small)
    
    private lazy var stackView            = UIStackView()
    private let authVM : AuthVM?     = AuthVM()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureHeadLabel()
        configureTextField()
        configureForgotPassword()
        configureStackView()
    }
    
    
    // MARK: - UI Configuration
    func configureViewController() {
        view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.addSubviewsExt(HeadLabel, emailTextField, forgotPasswordButton, stackView)
    }
    
    private func configureHeadLabel() {
        HeadLabel.text = "Forgot Password"
        
        HeadLabel.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         //trailing: view.trailingAnchor,
                         padding: .init(top: 80, leading: 20))
    }
    
    private func configureTextField() {
        emailTextField.anchor(top: HeadLabel.bottomAnchor,
                                 leading: view.leadingAnchor,
                                 trailing: view.trailingAnchor,
                                 padding: .init(top: 40, leading: 20, trailing: 20),
                                 size: .init(heightSize: 50))
    }
    
    private func configureForgotPassword(){
        forgotPasswordButton.configuration?.cornerStyle = .capsule

        forgotPasswordButton.anchor(top: emailTextField.bottomAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            padding: .init(top: 20, leading: 20, trailing: 20),
                            size: .init(heightSize: 50))
        
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    private func configureStackView() {
        stackView.axis          = .horizontal
        
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(signInButton)
        
        infoLabel.text = "Already have an account?"

        stackView.anchor(top: forgotPasswordButton.bottomAnchor,
                         padding: .init(top: 5))
        
        stackView.centerXInSuperview()
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func didTapForgotPassword(){
        //Email & Password Validation
        
        guard let email = emailTextField.text else {
            return
        }
        
        guard email.isValidEmail(email: email) else {
            presentAlert(title: "Alert!", message: "Invalide Email Address", buttonTitle: "Ok")
            return
        }
        
        authVM?.resetPassword(email: email) { [weak self] success, error in
            guard let self = self else { return }

            if success {
                self.presentAlert(title: "Alert!", message: "Password renewal request sent to your e-mail address 🥳", buttonTitle: "Ok")
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                self.presentAlert(title: "Alert!", message: error, buttonTitle: "Ok")
            }
        }
    }
    
    @objc private func didTapSignIn() {

        self.navigationController?.popToRootViewController(animated: true)
    } 
}
