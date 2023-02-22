//
//  LocationCollectionViewCell.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 21.02.2023.
//
import UIKit
import Kingfisher
import Combine

class LocationCollectionViewCell: UICollectionViewCell {
    
    private var subscriptions: Set<AnyCancellable> = []
    
    static let reuseIdentifier = "LocationCellCollectionViewCell"
    
    var nameLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = .boldSystemFont(ofSize: 16)
        lbl.textColor = .white
        lbl.tintColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = ""
        return lbl
    }()
    
    var typeLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15)
        lbl.textColor = .white
        lbl.tintColor = .white
        lbl.textAlignment = .left
        lbl.text = ""
        return lbl
    }()
    
    var viewModel: LocationCellViewModel? {
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
        addSubview(nameLabel)
        addSubview(typeLabel)
    }
    
    func setupBindings() {
        guard let viewModel = viewModel else{return }
        
        //short version
        viewModel.namePublisher
            .assign(to: \.text, on: nameLabel)
            .store(in: &subscriptions)
        
        viewModel.typePublisher
            .assign(to: \.text, on: typeLabel)
            .store(in: &subscriptions)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .black.withAlphaComponent(0.45)
        layer.cornerRadius = 18
        layer.shadowOffset = .init(width: 0, height: 1)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.black.cgColor
        
        nameLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bot: nil, right: contentView.rightAnchor, topConstant: 24, leftConstant: 8, botConstant: 0, rightConstant: 8, width: 0, height: 24)
        
        typeLabel.anchor(top: nil, leading: contentView.leadingAnchor, bot: contentView.bottomAnchor, right: contentView.rightAnchor, topConstant: 0, leftConstant: 8, botConstant: 8, rightConstant: 8, width: 0, height: 16)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        subscriptions.removeAll()
        nameLabel.text = ""
        typeLabel.text = ""
    }
    
}
