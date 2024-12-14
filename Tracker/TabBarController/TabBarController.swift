import UIKit

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewControllers()
    setupTabBarAppearance()
  }
  
  private func setupViewControllers() {
    let trackerVC = createTrackersViewController()
    let statisticsVC = createStatisticsViewController()
    
    self.viewControllers = [
      UINavigationController(rootViewController: trackerVC),
      UINavigationController(rootViewController: statisticsVC)
    ]
  }
  
  private func createTrackersViewController() -> UIViewController {
    let trackerVC = TrackerViewController()
    trackerVC.tabBarItem = UITabBarItem(title: "Трекеры", image: UIImage(named: "TrackerNavBarItem"), tag: 0)
    return trackerVC
  }
  
  private func createStatisticsViewController() -> UIViewController {
    let statisticsVC = StatisticsViewController()
    statisticsVC.tabBarItem = UITabBarItem(title: "Статистика", image: UIImage(named: "StatisticsNavBarItem"), tag: 0)
    return statisticsVC
  }
  
  private func setupTabBarAppearance() {
    tabBar.barTintColor = UIColor(named: "YPBlue")
  }
  
}
