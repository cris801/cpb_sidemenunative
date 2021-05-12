//
//  HomeViewController.swift
//  sidemenunative
//
//  Created by Cristian Peña Barrios on 07/05/21.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTabMenuButton()
}

class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Home"
        
        // Para cambiar el color del titulo del NC
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didTabMenuButton))
   
    }

    @objc func didTabMenuButton() {
        delegate?.didTabMenuButton()
    }
}


