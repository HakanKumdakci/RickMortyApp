
//  CharacterDetailViewController.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 15.02.2023.
//

import UIKit

final class CharacterDetailViewController: UIViewController {
    
    var imageView: UIImageView = {
        var img = UIImageView()
        img.contentMode = .scaleToFill
        img.image = nil
        return img
    }()
    
    var viewModel: CharacterDetailViewModel
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    func setupViews() {
        view.addSubview(imageView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
}
