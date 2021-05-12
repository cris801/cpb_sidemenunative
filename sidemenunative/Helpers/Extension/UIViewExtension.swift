//
//  UIViewExtension.swift
//  sidemenunative
//
//  Created by Cristian Peña Barrios on 08/05/21.
//


import UIKit

extension UIView {
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
