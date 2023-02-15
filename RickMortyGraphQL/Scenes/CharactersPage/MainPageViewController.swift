//
//  MainPageViewController.swift
//  RickMortyGraphQL
//
//  Created by Hakan on 23.01.2023.
//

import Foundation
import Combine
import UIKit

enum MainPageSection {
    case characters
    case episodes
    case locations
}

class MainPageViewController: UIViewController {
    
    lazy private var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout())
        cv.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource =  self
        cv.alwaysBounceVertical = true
        cv.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        cv.register(MyHeaderView.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: ViewConstants.mainPageHeaderReuse)
        return cv
    }()
    
    func compositionalLayout() -> UICollectionViewCompositionalLayout {
        let m = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.333))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .absolute(330))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 2)
            
            let firstHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            let firstHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: firstHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.orthogonalScrollingBehavior = .groupPaging
            section.supplementariesFollowContentInsets = false
            section.boundarySupplementaryItems = [firstHeader]
            
            return section
        }
        m.register(MyHeaderView.self, forDecorationViewOfKind: "HeaderView")
        
        return m
    }
    
    private var sections: [MainPageSection] = [.characters, .episodes, .locations]
    
    private let headerArray : [String] = ["Characters", "Episodes", "Locations"]
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private var viewModel : MainPageViewModel!
    
    var cellViewModels: [CharacterCellViewModel]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var coordinator: MainPageCoordinatorProtocol!
    
    deinit {
        self.subscriptions.removeAll()
    }
    
    init(viewModel: MainPageViewModel, coordinator: MainPageCoordinatorProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.makeRequest()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        setUpBindings()
    }
    
    func setUpBindings() {
        
        viewModel.characterDataViewModelPublisher
            .sink { [weak self] dataState in
                guard let self = self else {return }
                switch dataState {
                    case .error(let error):
                        print(error)
                    case .loading:
                        print()
                    case .viewModelData(let viewModels):
                        self.cellViewModels = viewModels
                }
            }
            .store(in: &subscriptions)
    }
    
    func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bot: view.bottomAnchor, right: view.rightAnchor, topConstant: 36, leftConstant: 18, botConstant: 36, rightConstant: 18, width: 0, height: 0)
    }
    
}

extension MainPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
            case .characters:
                viewModel.navigateToCharacterPage(coordinator: coordinator, index: indexPath.item)
            case .episodes:
                return
            case .locations:
                return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! MyHeaderView
        headerView.titleLabel.text = headerArray[indexPath.section]
        return headerView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
            case .characters:
                return 20
            case .episodes:
                return 0
            case .locations:
                return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
            case .characters:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
                // using indexPath.item at collectionView
                cell.viewModel = cellViewModels?[indexPath.item]
                return cell
            case .episodes:
                return UICollectionViewCell()
            case .locations:
                return UICollectionViewCell()
        }
    }
}



