//
//  IssuesVC.swift
//  seco
//
//  Created by Javier Calatrava on 29/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol IssueVCProtocol: AnyObject {
    func presentActivityIndicator()
    func removeActivityIndicator()
    func dismiss()
}
class IssueVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var issueView: IssueView!
    
    // MARK: - Callback
    var onDismiss: () -> Void = { /* Default empty block */}
    
    // MARK: - Private attributes
    var presenter: IssuePresenterProtocol = IssuePresenter()
    var issueVM: IssueVM?

    // MARK: - Constructor/Initializer
    public static func instantiate(presenter: IssuePresenterProtocol = IssuePresenter(), issueVM: IssueVM) -> IssueVC {
        let storyboard = UIStoryboard(name: R.storyboard.main.name, bundle: nil)
        guard let issuesVC = storyboard.instantiateViewController(withIdentifier: String(describing: IssueVC.self)) as? IssueVC else {
            return IssueVC()
        }
        issuesVC.presenter = presenter
        presenter.set(issueVC: issuesVC)
        issuesVC.issueVM = issueVM
        return issuesVC
    }
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViewController()
    }
    
    // MARK: - Private
    private func setupViewController() {
        self.issueView.set(issueVM: issueVM)
        self.issueView.onNameValueChanged = { [weak self] value in
            self?.issueVM?.name = value
        }
        self.issueView.onSurenameValueChanged = { [weak self] value in
            self?.issueVM?.surename = value
        }
        self.issueView.onEmailValueChanged = { [weak self] value in
            self?.issueVM?.email = value
        }
        self.issueView.onTimestampValueChanged = { [weak self] value in
            self?.issueVM?.timestamp = value
        }
        self.issueView.onReportValueChanged = { [weak self] value in
            self?.issueVM?.report = value
        }
        self.issueView.onPhoneValueChanged = { [weak self] value in
            self?.issueVM?.phone = value
        }
        self.issueView.onSaveAction = { [weak self] in
            guard let weakSelf = self else { return }
            guard let uwpIssueVM = weakSelf.issueVM,
                weakSelf.isFormProperlyFilled() else {
                weakSelf.presentAlertFormNotProperyFullfilled()
                return
            }
            let issue = Issue(issueVM: uwpIssueVM)
            weakSelf.presenter.save(issue: issue)
        }
    }
    
    private func presentAlertFormNotProperyFullfilled() {
        let alert = UIAlertController(title: R.string.localizable.issue_alert_title.key.localized,
                                      message: R.string.localizable.issue_alert_message.key.localized,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.alert_continue.key.localized,
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func isFormProperlyFilled() -> Bool {
        guard let uwpIssueVM = issueVM else { return false }
        guard uwpIssueVM.report.isEmpty || uwpIssueVM.report.count <= 200 else { return false}
        guard isValidEmail(uwpIssueVM.email) else { return false}
        
        return !uwpIssueVM.name.isEmpty && !uwpIssueVM.surename.isEmpty && !uwpIssueVM.email.isEmpty
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

extension IssueVC: IssueVCProtocol {
    
    func dismiss() {
        self.onDismiss()
    }
    
    func presentActivityIndicator() {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
    }

    func removeActivityIndicator() {
        SVProgressHUD.dismiss()
    }
}
