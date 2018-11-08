//
//  ViewController.swift
//  RxStockQuotes
//
//  Created by Vladimir Svetlanov on 07/11/2018.
//  Copyright © 2018 Vladimir Svetlanov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {
    
    private var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private let provider = NetworkProvider()
    private var quotations: Variable<[QuotationViewModel]> = Variable([])
    
    override func loadView() {
        title = "RxStockQuotes"
        tableView = UITableView(frame: UIScreen.main.bounds)
        tableView.register(QuotationCell.self, forCellReuseIdentifier: "cell")
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCellConfiguration()
        setupTimer()
        loadData()
    }
    
    private func setupCellConfiguration() {
        //Equivalent of cell for row at index path
        quotations.asObservable()
            .bind(to: tableView
                .rx
                .items(cellIdentifier: "cell", cellType: QuotationCell.self)) {
                    row, quotation, cell in
                    cell.update(with: quotation)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupTimer() {
        Observable<Int>.interval(5.0, scheduler: SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.loadData()
            }).disposed(by: disposeBag)
    }
    
    private func loadData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        provider.getQuotations()?.subscribe(onNext: { [weak self] (quotations) in
            self?.quotations.value = quotations.map({
                return QuotationViewModel.init(name: $0.name,
                                               last: $0.last,
                                               highestBid: $0.highestBid,
                                               percentChange: $0.percentChange)
            })
            }, onError: { (error) in
                print(error)
        }, onCompleted: {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }).disposed(by: disposeBag)
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

