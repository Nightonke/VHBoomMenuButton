//
//  SimpleCircleButtonVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by viktorhuang on 2017/5/2.
//  Copyright © 2017年 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class SimpleCircleButtonVC: BoomMenuButtonVC, UITableViewDelegate, UITableViewDataSource {

    static let identifier = "SimpleCircleButtonVCIdentifier"
    
    var datas: [String] = [String]()
    var piecesAndButtons: [(PiecePlaceEnum, ButtonPlaceEnum)] = [(PiecePlaceEnum, ButtonPlaceEnum)]()
    
    @IBOutlet weak var bmb: BoomMenuButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmb.buttonEnum = .simpleCircle
        
        initializeDatas()
        tableView(tableView, didSelectRowAt: IndexPath.init(row: 0, section: 0))
    }
    
    func initializeDatas() {
        BuilderManager.initializeDatasForSimpleCircleButton(datas: &datas, piecesAndButtons: &piecesAndButtons)
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bmb.piecePlaceEnum = piecesAndButtons[indexPath.row].0
        bmb.buttonPlaceEnum = piecesAndButtons[indexPath.row].1
        bmb.clearBuilders()
        for _ in 0..<bmb.piecePlaceEnum.pieceNumber() {
            bmb.addBuilder(BuilderManager.simpleCircleButtonBuilder())
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: SimpleCircleButtonVC.identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: SimpleCircleButtonVC.identifier)
        }
        cell!.textLabel?.text = datas[indexPath.row]
        return cell!
    }
}
