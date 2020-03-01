//
//  ReportTVC.swift
//  seco
//
//  Created by Javier Calatrava on 01/03/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import UIKit

class ReportTVC: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lblAttributeName: UILabel!
    @IBOutlet weak var txtReport: UITextView!

    // MARK: - Callbacks
    var onReportValueChanged: (String) -> Void = { _ in /* Default empty block*/ }

    // MARK: - Private attributes
    private var attributePersonType: AttributeIssueType?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupView()
    }

    // MARK: - Public methods
    func set(attributePersonType: AttributeIssueType) {

        self.attributePersonType = attributePersonType
        self.refreshView()
    }

    //  MARK: - Private/Internal methods
    private func setupView() {
        self.selectionStyle = .none
        self.txtReport.delegate = self
    }

    private func refreshView() {
        lblAttributeName.text = attributePersonType?.getText()
        txtReport.text = attributePersonType?.getValue()
    }
}

extension ReportTVC: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text,
            let uwpAttributePersonType = attributePersonType else { return }
        uwpAttributePersonType.onValueChanged(reportTVC: self, value: text)
    }

}
