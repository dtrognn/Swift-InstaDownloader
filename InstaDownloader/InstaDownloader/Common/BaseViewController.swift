//
//  BaseViewController.swift
//  InstaDownloader
//
//  Created by Vu Duc Trong on 18/04/2023.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Self.self, #function)
        configSubViews()
    }

    func configSubViews() {
        print(Self.self, #function)
    }

    func shoudClose() -> Bool {
        return true
    }

    func displayIndicator(isShow: Bool) {
        if isShow {
            ProgressHUD.show()
        } else {
            ProgressHUD.dismiss()
        }
    }

    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach {
            alert.addAction($0)
        }
        present(alert, animated: true)
    }
}
