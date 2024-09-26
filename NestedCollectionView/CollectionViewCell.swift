//
//  CollectionViewCell.swift
//  NestedCollectionView
//
//  Created by Vicky on 2024/9/25.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        return label
    }()
    
    func setupView(text: String) {
        setupConstraint()
        label.text = text
    }
    
    private func setupConstraint() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(customView)
        customView.addSubview(label)
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            
            label.topAnchor.constraint(equalTo: customView.topAnchor, constant: 2),
            label.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -2),
            label.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 2),
            label.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -2)
        ])
    }
    
}
