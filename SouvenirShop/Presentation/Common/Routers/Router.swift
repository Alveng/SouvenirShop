//
//  Router.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 15.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


protocol RouterNavigationable {
    func close()
}

// TODO: independ loading
protocol RouterLoadingable {
    func startLoading()
    func stopLoading()
    func stopLoading(with completion: (() -> ())?)
}

protocol RouterErrorable {
    func show(error: Error)
    func showAlert(with title: String?, message: String?)
}

class Router {
    
    weak var vc: UIViewController!
    private var isLoading = false
    private var loadingAlert: UIAlertController?
    
    init(vc: UIViewController) {
        self.vc = vc
    }
}

extension Router: RouterNavigationable {
    func close() {
        stopLoading { [weak self] in
            self?.vc.dismiss(animated: true, completion: nil)
        }
    }
}

extension Router: RouterLoadingable {
    
    func startLoading() {
        if loadingAlert == nil {
            loadingAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        }
        
        isLoading = true
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        loadingAlert!.view.addSubview(loadingIndicator)
        vc.present(loadingAlert!, animated: true, completion: nil)
    }
    
    func stopLoading() {
        guard isLoading else { return }
        
        isLoading = false
        loadingAlert!.dismiss(animated: true, completion: nil)
    }
    
    func stopLoading(with completion: (() -> ())? = nil) {
        guard isLoading else {
            guard completion != nil else { return }
            completion!()
            return
        }
        
        isLoading = false
        loadingAlert!.dismiss(animated: true, completion: completion)
    }
}

extension Router: RouterErrorable {
    
    func show(error: Error) {
        stopLoading { [weak self] in
            let alert = UIAlertController(title: K.Error.Title, message: error.localizedDescription, preferredStyle: .alert)
            let okAction = UIAlertAction(title: K.Error.OkAction, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self?.vc.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlert(with title: String?, message: String?) {
        stopLoading { [weak self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: K.Error.OkAction, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self?.vc.present(alert, animated: true, completion: nil)
        }
    }
}
