//
//  OrderVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by viktorhuang on 2017/5/4.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class OrderVC: BoomMenuButtonVC, UITableViewDelegate, UITableViewDataSource {

    static let identifier = "OrderVCIdentifier"
    
    @IBOutlet weak var bmb: BoomMenuButton!
    
    let orderEnums: [OrderEnum] = [.inOrder, .reverse, .random]
    let orderEnumNames: [String] = ["InOrder", "Reverse", "Random"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmb.buttonEnum = .simpleCircle
        bmb.piecePlaceEnum = .dot_9_1
        bmb.buttonPlaceEnum = .sc_9_1
        for _ in 0..<bmb.piecePlaceEnum.pieceNumber() {
            bmb.addBuilder(BuilderManager.simpleCircleButtonBuilder())
        }
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bmb.orderEnum = orderEnums[indexPath.row]
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderEnums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: OrderVC.identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: OrderVC.identifier)
        }
        cell!.textLabel?.text = orderEnumNames[indexPath.row]
        return cell!
    }

}
