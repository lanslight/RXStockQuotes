//
//  QuotationCell.swift
//  RxStockQuotes
//
//  Created by Vladimir Svetlanov on 08/11/2018.
//  Copyright © 2018 Vladimir Svetlanov. All rights reserved.
//

import UIKit

class QuotationCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    private lazy var lastLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    private lazy var highestBidLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    private lazy var percentChangeLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    private lazy var containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        containerView.addArrangedSubview(nameLabel)
        containerView.addArrangedSubview(lastLabel)
        containerView.addArrangedSubview(highestBidLabel)
        containerView.addArrangedSubview(percentChangeLabel)
    }
    
    func update(with viewModel: QuotationViewModel) {
        nameLabel.text = String(format: "Name: %@", viewModel.name)
        lastLabel.text = String(format: "Last: %f", viewModel.last)
        highestBidLabel.text = String(format: "Highest bid: %f", viewModel.highestBid)
        percentChangeLabel.text = String(format: "Percent Change: %f", viewModel.percentChange)
    }
}

