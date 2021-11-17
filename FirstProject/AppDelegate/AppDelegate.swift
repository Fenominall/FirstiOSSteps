//
//  AppDelegate.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: - Settings the appearence of UINavigationBar
        let navigationBarAppearence = UINavigationBarAppearance()
        // Tint color
        navigationBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearence.backgroundColor = UIColor.darkGray
        UINavigationBar.appearance().standardAppearance = navigationBarAppearence
        
        // MARK: - Settings the navigation
        let navVC = UINavigationController()
        navVC.navigationBar.prefersLargeTitles = true
        let coordinator = MainCoordinator()
        coordinator.navigationController = navVC
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navVC
        
        coordinator.start()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

