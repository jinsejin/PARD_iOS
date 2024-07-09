//
//  ReasonController.swift
//  PARD
//
//  Created by 김하람 on 7/3/24.
//

import UIKit

func getReason() {
    if let urlLink = URL(string: url + "/reason") {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlLink) { data, response, error in
            if let error = error {
                print("🚨 Error:", error)
                return
            }
            guard let JSONdata = data, !JSONdata.isEmpty else {
                print("🚨 [getReason] Error: No data or empty data")
                return
            }
            
            // 응답 데이터를 문자열로 변환하여 출력
            if let dataString = String(data: JSONdata, encoding: .utf8) {
                print("🌱 Response Data String: \(dataString)")
            } else {
                print("🚨🚨 Error: Unable to convert data to string")
            }
            
            let decoder = JSONDecoder()
            do {
                // 먼저 JSON 데이터를 단일 객체로 디코딩 시도
                if let reason = try? decoder.decode(Reason.self, from: JSONdata) {
                    print("✅ Success: \(reason)")
                } else {
                    // 단일 객체로 디코딩이 실패하면 배열로 디코딩 시도
                    let reasonArray = try decoder.decode([Reason].self, from: JSONdata)
                    print("✅ Success: \(reasonArray)")
                }
            } catch {
                print("🚨 Decoding Error:", error)
            }
        }
        task.resume()
    }
}
