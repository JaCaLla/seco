//
//  FormView.swift
//  seco
//
//  Created by Javier Calatrava on 04/04/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import SwiftUI
import Combine

protocol IssueVProtocol {
    func presentActivityIndicator()
    func removeActivityIndicator()
    func dismiss()
}

struct FormView: View {
    
     var onDismissPublisher: AnyPublisher<Void, Never> {
       return onDismissInternalPublisher.eraseToAnyPublisher()
     }
     public var onDismissInternalPublisher = PassthroughSubject<Void, Never>()
      
    @ObservedObject var issueUI: IssueUI = IssueUI()
    var presenter: IssueFormPresenterProtocol = IssuePresenterNew()
    @ObservedObject var keyboardHandler: KeyboardFollower = KeyboardFollower()

    @State var isWrongFilled: Bool = false
    
    init(issueUI: IssueUI,
         presenter: IssueFormPresenterProtocol = IssuePresenterNew(),
         keyboardHandler: KeyboardFollower = KeyboardFollower()) {
        self.issueUI = issueUI
        self.presenter = presenter
        self.keyboardHandler = keyboardHandler
        presenter.set(issueVC: self)
    }

    var body: some View {
        ScrollView {
            VStack {
                TextInputCell(text: "issue_name".localized, value: $issueUI.name.self)
                TextInputCell(text: "issue_surename".localized, value: $issueUI.surename.self)
                TextInputCell(text: "issue_email".localized, value: $issueUI.email.self)
                TextInputCell(text: "issue_phone".localized, value: $issueUI.phone.self)
                DateSelectorCell(text: "issue_timestamp".localized, value: $issueUI.timestamp.self)
                MultilineInputTextView(text: "issue_report".localized, value: $issueUI.report.self)
               // MultilineInputCell(value: $issueUI.report.self).frame(height: 200).bordered().padding()
                ActionCell {
                    guard self.isFormProperlyFilled() else {
                         self.isWrongFilled = true
                        return
                    }
                    self.isWrongFilled = false
                    let issue = Issue(issueUI: self.issueUI)
                    self.presenter.save(issue: issue)
                }
            }.padding(.bottom, keyboardHandler.keyboardHeight)
            .alert(isPresented: $isWrongFilled) {
                  Alert(title: Text("issue_alert_title".localized),
                        message: Text("issue_alert_message".localized),
                        dismissButton: .default(Text("OK"),
                                                action: {
                        }))
                }

        }
    }

    private func isFormProperlyFilled() -> Bool {
        guard issueUI.report.isEmpty || issueUI.report.count <= 200 else { return false}
        guard isValidEmail(issueUI.email) else { return false}

        return !issueUI.name.isEmpty &&
            !issueUI.surename.isEmpty &&
            !issueUI.email.isEmpty
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension FormView: IssueVProtocol {
    func presentActivityIndicator() {
        print("")
    }

    func removeActivityIndicator() {
        print("")
    }

    func dismiss() {
        self.onDismissInternalPublisher.send()
    }


}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        let issue = Issue(route: "asdf", name: "Pepito", surename: "Grillo", email: "pegri@mailinator.com", timestamp: 123, report: "blah, blah", phone: "123456789")
        let issueUI = IssueUI(issue: issue)
        return FormView(issueUI: issueUI)
    }
}
