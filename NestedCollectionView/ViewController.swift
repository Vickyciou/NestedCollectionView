//
//  ViewController.swift
//  NestedCollectionView
//
//  Created by Vicky on 2024/9/25.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var mTableView: UITableView = makeTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        mTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mTableView.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mTableView.reloadData()
        mTableView.layoutIfNeeded()
        let contentHeight = mTableView.contentSize.height
        mTableView.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(mTableView)
        NSLayoutConstraint.activate([
            mTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            mTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])
    }
    
    let mockData: [DataModel] = [
        DataModel(title: "Luxury Hotel Stay",
                  priceText: "$250 per night",
                  place: "New York",
                  promotionTags: ["Free Breakfast", "Room Upgrade", "Welcome Gift", "Complimentary Wi-Fi", "Fitness Center Access"],
                  discountTags: ["Summer Sale", "Member Exclusive", "VIP Discount", "Birthday Offer", "Early Booking"]),

        DataModel(title: "Weekend Getaway",
                  priceText: "$150 per night",
                  place: "Los Angeles",
                  promotionTags: ["Late Check-out", "Spa Access"],
                  discountTags: ["10% Off", "Flash Deal"]),

        DataModel(title: "Adventure Trip",
                  priceText: "$120 per night",
                  place: "Denver",
                  promotionTags: ["Guided Tour Included", "Free Equipment Rental", "Complimentary Dinner", "Shuttle Service", "Outdoor Adventure Package"],
                  discountTags: ["Early Bird Discount", "Holiday Special", "Student Discount", "Off-Season Deal", "Last Minute Offer"]),

        DataModel(title: "Beach Resort Package",
                  priceText: "$300 per night",
                  place: "Miami",
                  promotionTags: ["All Inclusive", "Free Drinks"],
                  discountTags: ["Black Friday Deal", "Stay 3 Pay 2"]),

        DataModel(title: "Mountain Cabin Retreat",
                  priceText: "$180 per night",
                  place: "Aspen",
                  promotionTags: ["Fireplace Included", "Private Hot Tub", "Nature Hiking Guide", "Free Breakfast Basket", "Discounted Ski Pass"],
                  discountTags: ["Winter Sale", "New Year Discount", "Extended Stay Offer", "Couple's Package", "Loyalty Rewards"])
    ]


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("Cannot created TableViewCell")
        }
        cell.setupView(data: mockData[indexPath.row])
        
        return cell
    }
    
    
}

extension ViewController {
    private func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }
}

struct DataModel {
    let title: String
    let priceText: String
    let place: String
    let promotionTags: [String]
    let discountTags:  [String]
}

