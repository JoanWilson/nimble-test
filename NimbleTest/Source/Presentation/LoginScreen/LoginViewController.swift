//
//  LoginViewController.swift
//  NimbleTest
//
//  Created by Joan Wilson Oliveira on 03/11/23.
//

import UIKit

public final class LoginViewController: UIViewController {
    private let contentView = LoginView()
    
    public override func loadView() {
        super.loadView()
        view = contentView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
