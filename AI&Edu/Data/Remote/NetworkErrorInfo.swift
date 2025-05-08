//
//  NetworkErrorInfo.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 08/05/25.
//

import Foundation

struct NetworkErrorInfo {
    struct Status {
        let code: String?
        let message: String?
    }

    let path: String?
    let status: Status?
    let message: String?
}
