//
//  TextOutsideCircleButtonVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by Nightonke on 2017/5/3.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class TextOutsideCircleButtonVC: BoomMenuButtonVC, UITableViewDelegate, UITableViewDataSource {

    static let identifier = "TextOutsideCircleButtonVCIdentifier"
    
    var datas: [String] = [String]()
    var piecesAndButtons: [(PiecePlaceEnum, ButtonPlaceEnum)] = [(PiecePlaceEnum, ButtonPlaceEnum)]()
    
    @IBOutlet weak var bmb: BoomMenuButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmb.buttonEnum = .textOutsideCircle
        
        initializeDatas()
        tableView(tableView, didSelectRowAt: IndexPath.init(row: 0, section: 0))
    }
    
    func initializeDatas() {
        BuilderManager.initializeDatasForTextOutsideCircleButton(datas: &datas, piecesAndButtons: &piecesAndButtons)
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bmb.piecePlaceEnum = piecesAndButtons[indexPath.row].0
        bmb.buttonPlaceEnum = piecesAndButtons[indexPath.row].1
        bmb.clearBuilders()
        for _ in 0..<bmb.piecePlaceEnum.pieceNumber() {
            bmb.addBuilder(BuilderManager.textOutsideCircleButtonBuilder())
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: TextOutsideCircleButtonVC.identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: TextOutsideCircleButtonVC.identifier)
        }
        cell!.textLabel?.text = datas[indexPath.row]
        return cell!
    }

}
