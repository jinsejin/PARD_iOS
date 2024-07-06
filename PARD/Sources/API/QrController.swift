//
//  QrController.swift
//  PARD
//
//  Created by 김하람 on 7/3/24.
//

import UIKit

func getValidQR(with qrUrl: String) {
    print("❤️ \(qrUrl)")
    guard let url = URL(string: "\(url)/validQR") else {
        print("🚨 Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: AnyHashable] = [
        "qrUrl": qrUrl,
        "seminar": "part"
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
