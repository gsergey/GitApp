//
//  UIViewController+Extension.swift
//  Git App
//
//  Created by Sergey Galagan on 22.03.2021.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showErrorAlert(_ message: String) {
        showAlert(message, title: NSLocalizedString("Error", comment: ""), handler: nil)
    }
    
    func showDefaultErrorAlert() {
        showAlert("Something went wrong", title: NSLocalizedString("Error", comment: ""), handler: nil)
    }
    
    func showAlert(_ message: String) {
        showAlert(message, handler: nil)
    }
    
    func showAlert(_ message: String, handler: ((UIAlertAction) -> Void)?) {
        showAlert(message, title: NSLocalizedString("isPay", comment: ""), handler: handler)
    }
    
    func showAlert(_ message: String, handler: ((UIAlertAction) -> Void)?, title: String) {
        showAlert(message, title: title, handler: handler)
    }
    
    func showAlert(_ message: String, title: String, handler: ((UIAlertAction) -> Void)?) {
        let action = UIAlertAction(title: "OK", style: .default, handler: handler)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        
        appPresent(alert, animated: true, completion: nil)
    }
    
    @objc func dismissAlert() {
        dismiss(animated: true, completion: nil)
    }
    
    func appPresent(_ viewController: UIViewController, animated: Bool, completion: (() -> Swift.Void)? = nil) {
        self.present(viewController, animated: animated, completion: completion)
    }
    
    
    //MARK: - MBProgressHUD funcs
    func showProgressHUD(_ parentView: UIView) {
        let spinnerActivity = MBProgressHUD.showAdded(to: parentView, animated: true);
        spinnerActivity.isUserInteractionEnabled = true;
        spinnerActivity.show(animated: true)
    }
    
    func closeProgressHUD(_ parentView: UIView) {
        MBProgressHUD.hide(for: parentView, animated: true)
    }
}
