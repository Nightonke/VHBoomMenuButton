//
//  TableViewVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by viktorhuang on 2017/5/5.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class TableViewVC: BoomMenuButtonVC, UITableViewDelegate, UITableViewDataSource {

    static let identifier = "TableViewVCIdentifier"
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = (tableView.dequeueReusableCell(withIdentifier: TableViewVC.identifier) as? BMBTableViewCell) {
            cell.label.text = String.init(format: "No.%d", indexPath.row)
            
            cell.bmb1.buttonEnum = .simpleCircle
            cell.bmb1.piecePlaceEnum = .share
            cell.bmb1.buttonPlaceEnum = .sc_9_1
            cell.bmb1.isInList = true
            cell.bmb1.clearBuilders()
            for _ in 0..<cell.bmb1.buttonPlaceEnum.buttonNumber() {
                cell.bmb1.addBuilder(BuilderManager.simpleCircleButtonBuilder())
            }
            
            cell.bmb2.buttonEnum = .ham
            cell.bmb2.piecePlaceEnum = .ham_3
            cell.bmb2.buttonPlaceEnum = .ham_3
            cell.bmb2.isInList = true
            cell.bmb2.clearBuilders()
            for _ in 0..<cell.bmb2.piecePlaceEnum.pieceNumber() {
                cell.bmb2.addBuilder(BuilderManager.hamButtonBuilder())
            }
            
            cell.bmb3.buttonEnum = .simpleCircle
            cell.bmb3.piecePlaceEnum = .dot_9_1
            cell.bmb3.buttonPlaceEnum = .sc_9_1
            cell.bmb3.isInList = true
            cell.bmb3.clearBuilders()
            for _ in 0..<cell.bmb3.piecePlaceEnum.pieceNumber() {
                cell.bmb3.addBuilder(BuilderManager.simpleCircleButtonBuilder())
            }
            
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: TableViewVC.identifier)!
        }
    }

}
