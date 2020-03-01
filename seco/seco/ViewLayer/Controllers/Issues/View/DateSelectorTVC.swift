//
//  DateSelectorTVC.swift
//  seco
//
//  Created by Javier Calatrava on 29/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import UIKit

class DateSelectorTVC: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lblAttributeName: UILabel!
    @IBOutlet weak var pckTimeStamp: UIDatePicker!

    // MARK: - Callbacks
    var onTimestampValueChanged: (Date) -> Void = { _ in /* Default empty block*/ }

    // MARK: - Private attributes
    private var attributePersonType: AttributeIssueType?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    // MARK: - public methods
    func set(attributePersonType: AttributeIssueType) {

        self.attributePersonType = attributePersonType
        self.refreshView()
    }
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        self.onTimestampValueChanged(picker.date)
    }

    //  MARK: - Private/Internal methods
    private func setupView() {
        self.selectionStyle = .none
        pckTimeStamp.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)

    }

    private func refreshView() {
        lblAttributeName.text = attributePersonType?.getText()
        if let date = attributePersonType?.getDate() {
            pckTimeStamp.date = date
        }
    }

}
