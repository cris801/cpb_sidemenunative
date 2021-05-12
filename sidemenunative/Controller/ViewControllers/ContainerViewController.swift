//
//  ViewController.swift
//  sidemenunative
//
//  Created by Cristian Peña Barrios on 07/05/21.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    var navVC: UINavigationController?
    
    let menuVC = MenuViewController()
    
    let homeVC = HomeViewController()
    let infoVC = InfoViewController()
    let appRating = AppRatingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVCs()
    }
    

    func addChildVCs() {
        // Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // Home
        homeVC.delegate = self
        
        let navVC  = UINavigationController(rootViewController: homeVC)
        navVC.navigationBar.barTintColor = UIColor.blue
        navVC.navigationBar.tintColor = UIColor.white
        
        navVC.navigationBar.isTranslucent = false // quitar la transparencia del nc
//        navVC.navigationBar.barStyle = .default
        
        
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        
        self.navVC = navVC
    }
    
    func addConstraints(v: UIView)  {
        
        var constraints = [NSLayoutConstraint]()
        
        let nch: CGFloat = navVC!.navigationBar.frame.size.height
        // Add
        constraints.append(v.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(v.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(v.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(v.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: nch))
        
        NSLayoutConstraint.activate(constraints)
        
    }
    

    
    // con este metodo sobre escrito se cambiar el color del statusbar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension ContainerViewController: MenuViewControllerDelegate {
    
    func didSelect(menuItem: MenuViewController.MenuOption) {
        toggleMenu (completion: nil)
        switch menuItem {
        
        case .home:
            self.resetToHome()
        case .info:
            // Add info child
            self.addInfo()
            
        case .appRating:
            // Add App Rating
            self.addAppRating()
            
        case .shareapp:
            break
            
        case .settings:
            break
        }
    }
    
    func resetToHome() {
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        appRating.view.removeFromSuperview()
        appRating.didMove(toParent: nil)
        homeVC.title = "Home"
        
    }
    
    func addInfo() {
        let vc = infoVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
//        vc.view.frame = view.frame
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(v: vc.view)
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    
    func addAppRating() {
        let vc = appRating
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
//        vc.view.frame = view.frame
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(v: vc.view)
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
}


extension ContainerViewController: HomeViewControllerDelegate {
    // Animate the menu
    func didTabMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            // close it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                // porcentaje que se mostrara en pantalla
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
            
        case .opened:
            // open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                
                self.navVC?.view.frame.origin.x = 0
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}



