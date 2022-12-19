//
//  TermsOfServicesModel.swift
//  VirtualLearn
//
//  Created by Anushree J C on 19/12/22.
//

import Foundation
class TermsOfServicesModel {
    var termsOfServicesId: String
    var content: String

    init(termsOfServicesId: String, content: String) {
        self.termsOfServicesId = termsOfServicesId
        self.content = content
    }
}
