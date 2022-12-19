//
//  PrivacyPolicyModel.swift
//  VirtualLearn
//
//  Created by Anushree J C on 19/12/22.
//

import Foundation

class PrivacyPolicyModel {
    var privacyPolicyId: String
    var content: String

    init(privacyPolicyId: String, content: String) {
        self.privacyPolicyId = privacyPolicyId
        self.content = content
    }
}
