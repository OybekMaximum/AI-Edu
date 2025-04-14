//
//  TabBarController.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import UIKit
import Combine

class TabBarController: UITabBarController {
    private let tabBarSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        return view
    }()

    private let tabBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundPrimary
        return view
    }()

    private let tabBarBackgroundBlurView: UIVisualEffectView = {
        let effectView = UIVisualEffectView()
        effectView.effect = UIBlurEffect(style: .regular)
        return effectView
    }()

    private var cancellable: AnyCancellable?
    let viewModel: TabBarViewModel

    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configTabBar()
        addSubviews()
        delegate = self
//        requestNotificationPermission()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutTabBar()
        layoutTabBarBackgroundView()
    }

    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        updateTabBarItemImageInsets()
    }

    private func configTabBar() {
        let itemAppearance = UITabBarItemAppearance()
//        itemAppearance.normal.badgePositionAdjustment.horizontal = 6
//        itemAppearance.normal.badgePositionAdjustment.vertical = 6
//        itemAppearance.selected.badgePositionAdjustment.horizontal = 18
//        itemAppearance.selected.badgePositionAdjustment.vertical = 6
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.stackedLayoutAppearance = itemAppearance
        tabBarAppearance.inlineLayoutAppearance = itemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = itemAppearance
        tabBarAppearance.configureWithTransparentBackground()
        tabBar.standardAppearance = tabBarAppearance
    }

    // Set image insets to center tabBar items vertically to adjust the space between image and title
    private func updateTabBarItemImageInsets() {
        let verticalInset: CGFloat = 4
        tabBar.items?.forEach { tabBarItem in
            tabBarItem.imageInsets = UIEdgeInsets(top: verticalInset, left: 0, bottom: -verticalInset, right: 0)
        }
    }

    private func addSubviews() {
        tabBarBackgroundView.addSubview(tabBarBackgroundBlurView)

        tabBar.addSubview(tabBarBackgroundView)
        tabBar.addSubview(tabBarSeparatorView)
    }

    private func layoutTabBar() {
        let height = 56 + view.safeAreaInsets.bottom
        let width = view.bounds.width
        let x: CGFloat = 0
        let y: CGFloat = view.bounds.height - height
        tabBar.frame = CGRect(x: x, y: y, width: width, height: height)
    }

    private func layoutTabBarBackgroundView() {
        let width = tabBar.bounds.width
        let height = tabBar.bounds.height
        tabBarBackgroundView.frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        tabBarSeparatorView.frame = CGRect(origin: .zero, size: CGSize(width: width, height: 1))
        tabBarBackgroundBlurView.frame = tabBarBackgroundView.bounds
    }

//    private func requestNotificationPermission() {
//        Task { @MainActor in
//            do {
//                let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
//                if granted {
//                    NotificationCenter.default.post(name: .notificationPermissionGranted, object: nil)
//                }
//            } catch {
//                print("Error requesting notification permissions: \(error.localizedDescription)")
//            }
//        }
//    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // Prevents the default animation from being applied
        UIView.performWithoutAnimation {
            tabBarController.selectedViewController = viewController
        }

        return false
    }
}

