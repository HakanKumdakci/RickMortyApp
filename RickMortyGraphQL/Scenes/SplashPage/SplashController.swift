//
//  ViewController.swift
//  SpaceXApp
//
//  Created by Hakan on 11.11.2022.
//

import UIKit
import Apollo
import Kingfisher



class SplashController: UIViewController {
    
    var coordinator: SplashCoordinatorProtocol?
    
    var splashLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = .systemFont(ofSize: 24)
        lbl.textColor = .black
        lbl.tintColor = .black
        lbl.textAlignment = .center
        lbl.text = "Example Splash Screen"
        return lbl
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let coordinator = coordinator {
            sleep(1)
            coordinator.navigateToCharactersPage()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(splashLabel)
        
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        self.splashLabel.anchor(top: nil, leading: nil, bot: nil, right: nil, topConstant: 0, leftConstant: 0, botConstant: 0, rightConstant: 0, width: 0, height: 0, centerX: view.centerXAnchor, centerY: view.centerYAnchor)   
    }


}
