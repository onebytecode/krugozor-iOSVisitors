//
//  OnboardPageVC.swift
//  krugozor-visitorsApp
//
//  Created by Stanly Shiyanovskiy on 27.09.17.
//  Copyright © 2017 oneByteCode. All rights reserved.
//

import UIKit

class OnboardPageVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    static func storyboardInstance() -> OnboardPageVC? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? OnboardPageVC
    }

    // MARK: - Properties -
    let contentImages = [("Onboard_1", "Landing Page #1."), ("Onboard_2", "Landing Page #2.")]

    // MARK: - Outlets -

    override func viewDidLoad() {
        self.delegate = self
        self.dataSource = self

        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            self.setViewControllers(startingViewControllers, direction: .forward, animated: false, completion: nil)
        }

        setupPageControl()
    }

    func setupPageControl() {
        self.view.backgroundColor = UIColor.white
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.CustomColors.second
        appearance.currentPageIndicatorTintColor = UIColor.CustomColors.first
        appearance.backgroundColor = UIColor.white
    }

    // MARK: - UIPageViewControllerDataSource methods -
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        let itemController = viewController as! OnboardTemplateVC

        if itemController.itemIndex > 0 {

            return getItemController(itemController.itemIndex - 1)
        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        if let itemController = viewController as? OnboardTemplateVC {

        if itemController.itemIndex + 1 < contentImages.count {

            return getItemController(itemController.itemIndex + 1)

        } else if itemController.itemIndex + 1 == contentImages.count {

            let itemController2 = LogInVC.storyboardInstance()!

            return getItemController(itemController2.itemIndex + contentImages.count)
            }
        }

        return nil
    }

    func getItemController(_ itemIndex: Int) -> UIViewController? {

        if itemIndex < contentImages.count {
            if let pageVC = OnboardTemplateVC.storyboardInstance() {
                pageVC.itemIndex = itemIndex
                pageVC.contentModel = contentImages[itemIndex]
                return pageVC
            }
        } else if itemIndex == contentImages.count {
                if let loginVC = LogInVC.storyboardInstance() {

                return loginVC
            }
        }

        return nil
    }

    // MARK: - Page Indicator -
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return contentImages.count + 1
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

    // MARK: - Additions -
    func currentControllerIndex() -> Int {
        let pageItemController = self.currentController()

        if let controller = pageItemController as? OnboardTemplateVC {
            return controller.itemIndex
        }

        return -1
    }

    func currentController() -> UIViewController? {

        if (self.viewControllers?.count)! > 0 {
            return self.viewControllers![0]
        }

        return nil
    }

}
