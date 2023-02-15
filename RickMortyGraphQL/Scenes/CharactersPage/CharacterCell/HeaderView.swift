//
//  HeaderView.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 13.02.2023.
//

import Foundation
import UIKit

class MyHeaderView: UICollectionReusableView {
    let titleLabel: UILabel
    
    override init(frame: CGRect) {
        // Create the title label
        self.titleLabel = UILabel(frame: .zero)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.titleLabel.textColor = .black
        
        // Initialize the view with the title label
        super.init(frame: frame)
        
        self.addSubview(self.titleLabel)
        
        // Add constraints to center the title label
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
