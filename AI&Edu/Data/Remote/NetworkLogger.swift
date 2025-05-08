//
//  NetworkLogger.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 08/05/25.
//

import Foundation
import Alamofire

final class NetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "network.request.logger")

    func requestDidResume(_ request: Request) {
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
            ⚡️ Request Started: \(request)
            ⚡️ Body Data: \(body)
            """
        print(message)
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("⚡️ Response Received: \(response.debugDescription)")
    }
}
