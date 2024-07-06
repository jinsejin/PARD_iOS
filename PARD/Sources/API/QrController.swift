//
//  QrController.swift
//  PARD
//
//  Created by 김하람 on 7/3/24.
//

import Foundation

func getValidQR1(qrUrl : String) {
    if let urlLink = URL(string: url + "/validQR") {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlLink) { data, response, error in
            if let error = error {
                print("🚨 Error:", error)
                return
            }
            guard let JSONdata = data, !JSONdata.isEmpty else {
                print("🚨 Error: No data or empty data")
                return
            }
            
            // 응답 데이터를 문자열로 변환하여 출력
            if let dataString = String(data: JSONdata, encoding: .utf8) {
                print("Response Data String: \(dataString)")
            } else {
                print("🚨 Error: Unable to convert data to string")
            }
        }
        task.resume()
    }
}

func getValidQR(with qrUrl: String) {
    guard let url = URL(string: "\(url)/validQR") else {
        print("🚨 Invalid URL")
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: AnyHashable] = [
        "qrurl": qrUrl
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            print("🚨 Error: \(error?.localizedDescription ?? "Unknown error")")
            return
        }
        if let responseString = String(data: data, encoding: .utf8) {
            print("✅ success: \(responseString)")
        } else {
            print("🚨 Error: Unable to convert data to string")
        }
    }
    task.resume()
}
