//
//  HeaderSideMenuView.swift
//  sidemenunative
//
//  Created by Cristian Peña Barrios on 08/05/21.
//

import UIKit

final class HeaderSideMenuView: UIView {

    
    
    @IBOutlet private weak var myLabelFullName: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }

    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "HeaderSideMenuView") else {return}
        view.frame = self.bounds
        self.addSubview(view)
    }

    func configureView(nameUser: String) {

        myLabelFullName.text = nameUser
    }
}
