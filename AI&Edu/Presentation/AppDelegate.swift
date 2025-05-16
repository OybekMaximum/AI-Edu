//
//  AppDelegate.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 12/03/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configureDefaultUI()
        launchUI(with: launchOptions)

        let repository = CoursesRepository()

               Task { @MainActor in
                   do {
                       let courses = try await repository.getCourses()
                       print(courses)
                   } catch {
                       print("Error occured")
                   }
               }

        
        return true
    }

    private func configureDefaultUI() {
        let backButtonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        backButtonItem.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for: .default)
    }

    private func launchUI(with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()

        appCoordinator = AppCoordinator(window: window, launchOptions: launchOptions)
        appCoordinator?.start()
    }

}
