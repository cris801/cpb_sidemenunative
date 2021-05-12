//
//  MenuViewController.swift
//  sidemenunative
//
//  Created by Cristian Peña Barrios on 07/05/21.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOption)
}


class MenuViewController: UIViewController {
    
    weak var delegate: MenuViewControllerDelegate?
    
    enum MenuOption: String, CaseIterable {
        case home = "Home"
        case info = "Information"
        case appRating = "App Rating"
        case shareapp = "Share App"
        case settings = "Settings"
        
        var imageName: String {
            switch self {
            
            case .home:
                return "house"
            case .info:
                return "airplane"
            case .appRating:
                return "star"
            case .shareapp:
                return "message"
            case .settings:
                return "gear"
            }
        }
    }
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = nil
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    
    let grayColor = UIColor.white

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        addCustomTable()
        addHeaderTable()

        
        // fondo del menu
        view.backgroundColor = grayColor
    }
    
    func addCustomTable() {
        tableView.backgroundColor = .systemBackground // fondo de la tabla
        tableView.tableFooterView = UIView() // para quitar la lineas de espacios vacios
        tableView.alwaysBounceVertical = false //activar el scroll
        tableView.rowHeight = CGFloat(40) // Altura de cada una de las celdas
        tableView.separatorStyle = .none // Quitar las lineas de la tabla
    }
    
    func addHeaderTable() {
        var viewHeader: UIView{
            let frame = CGRect(x: 0.0,y: 0.0,width:  self.view.frame.size.width, height: 160.0)
            let vw = HeaderSideMenuView(frame: frame)
            vw.configureView(nameUser: "-Peña Barrios Cristian-")
            return vw
        } // Vista de encabezado del menu
        
        tableView.tableHeaderView = viewHeader // Agregamos el Header del side menu
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame =  CGRect(x: 0, y: view.safeAreaInsets.top , width: view.bounds.size.width, height:     view.bounds.size.height)
    }
    
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  MenuOption.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .black
        cell.imageView?.image = UIImage(systemName: MenuOption.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .black
        cell.backgroundColor = grayColor
        cell.contentView.backgroundColor = grayColor
        return cell
    }
    
    
    
}


extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOption.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
}
