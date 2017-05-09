//
//  ButtonPlaceAlignmentVC.swift
//  VHBoomMenuButtonSwiftDemo
//
//  Created by Nightonke on 2017/5/4.
//  Copyright © 2017 Nightonke. All rights reserved.
//

import UIKit
import BoomMenuButton

class ButtonPlaceAlignmentVC: BoomMenuButtonVC, UITableViewDelegate, UITableViewDataSource {

    static let identifier = "ButtonPlaceAlignmentVCIdentifier"
    
    @IBOutlet weak var bmb: BoomMenuButton!
    
    @IBOutlet weak var topMarginSlider: UISlider!
    @IBOutlet weak var bottomMarginSlider: UISlider!
    @IBOutlet weak var leftMarginSlider: UISlider!
    @IBOutlet weak var rightMarginSlider: UISlider!
    
    @IBOutlet weak var topMarginLabel: UILabel!
    @IBOutlet weak var bottomMarginLabel: UILabel!
    @IBOutlet weak var leftMarginLabel: UILabel!
    @IBOutlet weak var rightMarginLabel: UILabel!
    
    let buttonPlaceAlignmentEnums: [ButtonPlaceAlignmentEnum] = [.center,
                                                                 .top,
                                                                 .bottom,
                                                                 .left,
                                                                 .right,
                                                                 .topLeft,
                                                                 .topRight,
                                                                 .bottomLeft,
                                                                 .bottomRight]
    
    let buttonPlaceAlignmentEnumNames: [String] = ["Center",
                                                   "Top",
                                                   "Bottom",
                                                   "Left",
                                                   "Right",
                                                   "Top-Left",
                                                   "Top-Right",
                                                   "Bottom-Left",
                                                   "Bottom-Right"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmb.buttonEnum = .simpleCircle
        bmb.piecePlaceEnum = .dot_4_1
        bmb.buttonPlaceEnum = .sc_4_1
        for _ in 0..<bmb.piecePlaceEnum.pieceNumber() {
            bmb.addBuilder(BuilderManager.simpleCircleButtonBuilder())
        }
        
        onSliderValueChanged(topMarginSlider)
        onSliderValueChanged(bottomMarginSlider)
        onSliderValueChanged(leftMarginSlider)
        onSliderValueChanged(rightMarginSlider)
    }

    @IBAction func onSliderValueChanged(_ sender: UISlider) {
        if sender === topMarginSlider {
            bmb.buttonTopMargin = CGFloat(topMarginSlider.value)
            topMarginLabel.text = String.init(format: "Top margin = %.0lf point(s)", topMarginSlider.value)
        } else if sender === bottomMarginSlider {
            bmb.buttonBottomMargin = CGFloat(bottomMarginSlider.value)
            bottomMarginLabel.text = String.init(format: "Bottom margin = %.0lf point(s)", bottomMarginSlider.value)
        } else if sender === leftMarginSlider {
            bmb.buttonLeftMargin = CGFloat(leftMarginSlider.value)
            leftMarginLabel.text = String.init(format: "Left margin = %.0lf point(s)", leftMarginSlider.value)
        } else if sender === rightMarginSlider {
            bmb.buttonRightMargin = CGFloat(rightMarginSlider.value)
            rightMarginLabel.text = String.init(format: "Right margin = %.0lf point(s)", rightMarginSlider.value)
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bmb.buttonPlaceAlignmentEnum = buttonPlaceAlignmentEnums[indexPath.row]
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonPlaceAlignmentEnums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: ButtonPlaceAlignmentVC.identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: ButtonPlaceAlignmentVC.identifier)
        }
        cell!.textLabel?.text = buttonPlaceAlignmentEnumNames[indexPath.row]
        return cell!
    }
}
