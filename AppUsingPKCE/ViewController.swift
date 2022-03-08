//
//  ViewController.swift
//  AppUsingPKCE
//
//  Created by Eidinger, Marco on 12/16/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signIn(_ sender: Any) {
        // Example-specific values
        let bundleIdentifier = Bundle.main.bundleIdentifier!
        let auth0domain = "login.xero.com/identity/connect"
        let authorizeURL = "https://\(auth0domain)/authorize"
        let tokenURL = "https://identity.xero.com/connect/token"
        let clientId = "780A77878A6844D58A126F257DC8403B"
//        let redirectUri = "\(bundleIdentifier)://\(auth0domain)/ios/\(bundleIdentifier)/callback"
        let redirectUri = "https://xerointegration.satva.solutions"
        
        // Example-agnostic code
        let parameters = OAuth2PKCEParameters(authorizeUrl: authorizeURL,
                                        tokenUrl:tokenURL,
                                        clientId: clientId,
                                        redirectUri: redirectUri,
                                        callbackURLScheme: bundleIdentifier)

        let authenticator = OAuth2PKCEAuthenticator()
        authenticator.authenticate(parameters: parameters) { result in
            var message: String = ""
            switch result {
            case .success(let accessTokenResponse):
                message = accessTokenResponse.access_token
            case .failure(let error):
                message = error.localizedDescription
            }

            let alert = UIAlertController(
                title: "Result",
                message: message,
                preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .default, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}

