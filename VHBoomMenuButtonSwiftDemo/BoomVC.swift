//
//  BoomVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by Nightonke on 2017/5/4.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class BoomVC: BoomMenuButtonVC, UITableViewDelegate, UITableViewDataSource {

    static let identifier = "BoomVCIdentifier"
    
    let boomEnums: [BoomEnum] = [.straightLine,
                                 .parabola1,
                                 .parabola2,
                                 .parabola3,
                                 .parabola4,
                                 .horizontalThrow1,
                                 .horizontalThrow2,
                                 .random]
    
    let boomEnumNames: [String] = ["StraightLine",
                                   "Parabola1",
                                   "Parabola2",
                                   "Parabola3",
                                   "Parabola4",
                                   "HorizontalThrow1",
                                   "HorizontalThrow2",
                                   "Random"]
    
    @IBOutlet weak var bmb: BoomMenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmb.buttonEnum = .simpleCircle
        bmb.piecePlaceEnum = .dot_9_1
        bmb.buttonPlaceEnum = .sc_9_1
        bmb.duration = 2
        for _ in 0..<bmb.piecePlaceEnum.pieceNumber() {
            bmb.addBuilder(BuilderManager.simpleCircleButtonBuilder())
        }
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bmb.boomEnum = boomEnums[indexPath.row]
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boomEnums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: BoomVC.identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: BoomVC.identifier)
        }
        cell!.textLabel?.text = boomEnumNames[indexPath.row]
        return cell!
    }

}
