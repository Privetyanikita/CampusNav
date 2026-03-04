//
//  Ext.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    func add(subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
}
