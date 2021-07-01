//
//  SecondScreenView.swift
//  FirstProject
//
//  Created by Fenominall on 23.06.2021.
//


import UIKit

// -----------------START OF SECOND VIEW CONTROLLER-----------------
class SecondViewController: UIViewController {

//    Backgound image on the first screen
    private lazy var thirdScreenUIImage: UIImageView = {
        let secondBackImage = UIImageView()
        secondBackImage.image = UIImage(named: "gradient")
        secondBackImage.contentMode = .scaleAspectFit
        secondBackImage.translatesAutoresizingMaskIntoConstraints = false
        return secondBackImage
    }()
    
//    User default image on the second screen
    private lazy var userUImageView: UIImageView = {
        let userImage = UIImageView()
        userImage.image = UIImage(named: "user")
        userImage.contentMode = .scaleAspectFit
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()
    
//     Displaye the user`s name on the scond screen "processing..." to develop //
    private lazy var userGreetMessageLabel: UILabel = {
        let greetMessage = UILabel()
        greetMessage.translatesAutoresizingMaskIntoConstraints = false
        greetMessage.text = "Hey!"
        greetMessage.font = UIFont.boldSystemFont(ofSize: 40)
        greetMessage.adjustsFontSizeToFitWidth = true
        greetMessage.textAlignment = .center
        greetMessage.textColor = .white
        greetMessage.contentMode = .scaleAspectFit
//        processing...
        return greetMessage
    }()
    
//    Button to the third screen to update the user`s name and password
    private lazy var updateUserDataButton: UIButton = {
        let updateUserDataBtn = UIButton(type: .system)
        updateUserDataBtn.translatesAutoresizingMaskIntoConstraints = false
        updateUserDataBtn.backgroundColor = .orange
        updateUserDataBtn.setTitle("Update personal info", for: .normal)
        updateUserDataBtn.tintColor = .white
        updateUserDataBtn.layer.cornerRadius = 5
        updateUserDataBtn.clipsToBounds = true
        updateUserDataBtn.addTarget(self, action: #selector(UpdateButtonPressed), for: .touchUpInside)
        return updateUserDataBtn
    }()
    
// Navigation Controller for updateUserDataBtn "Button" to move to the third screen where the user can update his username and password
    @objc private func UpdateButtonPressed() {
        let rootVC = ThirdViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
//        present(navVC, animated: true)
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
// Log out Button to log out the user to the first screen
    private lazy var logOutUserButton: UIButton = {
        let logOutBtn = UIButton(type: .system)
        logOutBtn.translatesAutoresizingMaskIntoConstraints = false
        logOutBtn.backgroundColor = .blue
        logOutBtn.tintColor = .white
        logOutBtn.layer.cornerRadius = 5
        logOutBtn.clipsToBounds = true
        logOutBtn.setTitle("Log Out", for: .normal)
        logOutBtn.addTarget(self, action: #selector(LogOutUserPressed), for: .touchUpInside)
        return logOutBtn
    }()
    
//    Navigation Button to FirstViewController
    @objc private func LogOutUserPressed() {
        let rootVC = LoginScreenViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
//        navigationController?.pushViewController(rootVC, animated: true)
    }
    
//    Container to autolayout two place two elements User Login and User image
    private let userImageContainerView: UIView = {
        let topImageContainer = UIView(frame: .zero)
        topImageContainer.translatesAutoresizingMaskIntoConstraints = false
        return topImageContainer
    }()
    
//    Containter to autoplace button under the frinst autolayout container
    private let buttonsContainerView: UIView = {
        let buttonsContainerView = UIView(frame: .zero)
        buttonsContainerView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsContainerView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
// Function to add setups for the second view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Constraints of the second screen
        setupSecondScreenBackImageConstraints()
    }

    
//-------------------Start of constraints for the second screen-------------------
// Functions to add subviews of first second elements

    
    
////    Constraints for the background image on the second screen
    func setupSecondScreenBackImageConstraints() {
//         ThirdScreenUIImage
        view.addSubview(thirdScreenUIImage)
        
        NSLayoutConstraint.activate([
            thirdScreenUIImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
        ])

        setupUserImageConstraints()
        setupConstraintsForUpdateLogOutButtons()
    }
    
    
//    Constraints for the USER image on the second screen
    func setupUserImageConstraints() {
        
        
        view.addSubview(userImageContainerView)
        userImageContainerView.addSubview(userGreetMessageLabel)
        userImageContainerView.addSubview(userUImageView)


        NSLayoutConstraint.activate([

            userImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            userImageContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            userImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),


            userGreetMessageLabel.centerYAnchor.constraint(equalTo: userImageContainerView.centerYAnchor),
            userGreetMessageLabel.centerXAnchor.constraint(equalTo: userImageContainerView.centerXAnchor),
            userGreetMessageLabel.heightAnchor.constraint(equalTo: userImageContainerView.heightAnchor, multiplier: 0.75),

            userUImageView.heightAnchor.constraint(equalToConstant: 150),
            userUImageView.widthAnchor.constraint(equalToConstant: 150),
            userUImageView.topAnchor.constraint(equalTo: userGreetMessageLabel.bottomAnchor),
            userUImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userUImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userUImageView.heightAnchor.constraint(equalTo: userImageContainerView.heightAnchor, multiplier: 1),
        ])
    }

//    LOG OUT Button on the second screen
    func setupConstraintsForUpdateLogOutButtons() {
        
        view.addSubview(buttonsContainerView)
        buttonsContainerView.addSubview(updateUserDataButton)
        buttonsContainerView.addSubview(logOutUserButton)

        NSLayoutConstraint.activate([
            buttonsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            buttonsContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            buttonsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            updateUserDataButton.topAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor, constant: 30),
            updateUserDataButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            updateUserDataButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            updateUserDataButton.heightAnchor.constraint(equalToConstant: 50),
            updateUserDataButton.centerXAnchor.constraint(equalTo: buttonsContainerView.centerXAnchor),

            //  Constraints for LOG OUT Button on the second screen
            logOutUserButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logOutUserButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            logOutUserButton.heightAnchor.constraint(equalToConstant: 50),
            logOutUserButton.topAnchor.constraint(equalTo: updateUserDataButton.bottomAnchor, constant: 15),
            logOutUserButton.centerXAnchor.constraint(equalTo: updateUserDataButton.centerXAnchor),
        ])
    }
    
}
// -----------------END OF THIRD VIEW CONTROLLER-----------------
