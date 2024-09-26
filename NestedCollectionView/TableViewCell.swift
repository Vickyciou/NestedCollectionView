//
//  TableViewCell.swift
//  NestedCollectionView
//
//  Created by Vicky on 2024/9/25.
//

import UIKit

class TableViewCell: UITableViewCell {
    private let colorView = UIView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let placeLabel = UILabel()
    private lazy var bigStackView: UIStackView = makeStackView(spacing: 8)
    private lazy var upperStackView: UIStackView = makeStackView(spacing: 4)
    private lazy var downStackView: UIStackView = makeStackView(spacing: 6)
    private lazy var promotionCollectionView: UICollectionView = makeCollectionView()
    private lazy var discountCollectionView: UICollectionView = makeCollectionView()
    private var data: DataModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        promotionCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        discountCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        promotionCollectionView.reloadData()
        discountCollectionView.reloadData()
        promotionCollectionView.layoutIfNeeded()
        discountCollectionView.layoutIfNeeded()
        let promotionContentHeight = promotionCollectionView.collectionViewLayout.collectionViewContentSize.height
        let discountContentHeight = discountCollectionView.collectionViewLayout.collectionViewContentSize.height
        promotionCollectionView.heightAnchor.constraint(equalToConstant: promotionContentHeight).isActive = true
        discountCollectionView.heightAnchor.constraint(equalToConstant: discountContentHeight).isActive = true
    }
    
    func setupView(data: DataModel) {
        self.data = data
        titleLabel.text = data.title
        priceLabel.text = data.priceText
        placeLabel.text = data.place
        
    }
    
    private func setupConstraints() {
        colorView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        colorView.backgroundColor = .lightGray
        
        contentView.addSubview(bigStackView)
        bigStackView.addArrangedSubview(upperStackView)
        bigStackView.addArrangedSubview(downStackView)
        upperStackView.addArrangedSubview(colorView)
        upperStackView.addArrangedSubview(titleLabel)
        upperStackView.addArrangedSubview(promotionCollectionView)
        downStackView.addArrangedSubview(priceLabel)
        downStackView.addArrangedSubview(placeLabel)
        downStackView.addArrangedSubview(discountCollectionView)
        
        NSLayoutConstraint.activate([
            bigStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            bigStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -12),
            bigStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bigStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            colorView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension TableViewCell {
    private func makeStackView(spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }
    
    private func makeCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        return collectionView
    }
}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data else {
            fatalError("data did't exist.")
        }
        if collectionView == promotionCollectionView {
            return data.promotionTags.count
        } else {
            return data.discountTags.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = data,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {
            fatalError("CollectionViewCell created failed")
        }
        
        if collectionView == promotionCollectionView {
            cell.setupView(text: data.promotionTags[indexPath.row])
            cell.layoutIfNeeded()
            return cell
        } else {
            cell.setupView(text: data.discountTags[indexPath.row])
            cell.layoutIfNeeded()
            return cell
        }
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let data = data else {
//            fatalError("data did't exist.")
//        }
//        if collectionView == promotionCollectionView {
//            let tag = data.promotionTags[indexPath.row]
//            let size = tag.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)])
//            let sizeNew: CGSize = CGSize.init(width: ((size.width > self.frame.size.width) ? self.frame.size.width : (size.width + 4)), height: 20.0)
//            return sizeNew
//        } else {
//            let tag = data.discountTags[indexPath.row]
//            let size = tag.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0)])
//            let sizeNew: CGSize = CGSize.init(width: ((size.width > self.frame.size.width) ? self.frame.size.width : (size.width + 4)), height: 20.0)
//            return sizeNew
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        6
    }
    
}
