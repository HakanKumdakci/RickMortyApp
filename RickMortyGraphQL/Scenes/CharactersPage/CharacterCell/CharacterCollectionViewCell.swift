//
//  CharacterCollectionViewCell.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 27.01.2023.
//

import UIKit
import Kingfisher
import Combine

class CharacterCollectionViewCell: UICollectionViewCell {
    
    private var subscriptions: Set<AnyCancellable> = []
    
    static let reuseIdentifier = "CharacterCellCollectionViewCell"
    
    var imageView: UIImageView = {
        var img = UIImageView()
        img.contentMode = .scaleToFill
        img.image = nil
        return img
    }()
    
    var nameLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = .systemFont(ofSize: 18)
        lbl.textColor = .white
        lbl.tintColor = .white
        lbl.textAlignment = .center
        lbl.text = ""
        return lbl
    }()
    
    var viewModel: CharacterCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {return }
            skeletonView.removeFromSuperview()
            setupBindings()
            viewModel.requestForData()
        }
    }
    
    var skeletonView = SkeletonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        
        addSubview(skeletonView)
        addSubview(imageView)
        addSubview(nameLabel)
        
        
    }
    
    func setupBindings() {
        guard let viewModel = viewModel else{return }
        
        //short version
        viewModel.namePublisher
            .assign(to: \.text, on: nameLabel)
            .store(in: &subscriptions)
        
        //long version
        viewModel.imageUrlPublisher
            .sink { [weak self] url in
                if let imageUrl = URL(string: url ?? "") {
                    self?.imageView.kf.setImage(with: imageUrl)
                }
            }
            .store(in: &subscriptions)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .black.withAlphaComponent(0.9)
        layer.cornerRadius = 18
        layer.shadowOffset = .init(width: 0, height: 1)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        
        imageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bot: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 0, botConstant: 48, rightConstant: 0, width: 0, height: 0)
        
        nameLabel.anchor(top: imageView.bottomAnchor, leading: contentView.leadingAnchor, bot: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 6, leftConstant: 0, botConstant: 6, rightConstant: 0, width: 0, height: 0)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        subscriptions.removeAll()
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
        nameLabel.text = ""
    }
    
}
