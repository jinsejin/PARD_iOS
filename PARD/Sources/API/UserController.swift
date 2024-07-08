//
//  UserController.swift
//  PARD
//
//  Created by 김하람 on 7/3/24.
//

import UIKit

let url = "https://we-pard.store/v1"
var currentUser: User?

extension MainLoginViewController {
    func postLogin(with email: String) {
        guard let url = URL(string: "\(url)/users/login") else {
            print("🚨 Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: AnyHashable] = [
            "email": email
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
}

func getUsersMe() {
    if let urlLink = URL(string: url + "/users/me") {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlLink) { data, response, error in
            if let error = error {
                print("🚨 Error:", error)
                return
            }
            guard let JSONdata = data, !JSONdata.isEmpty else {
                print("🚨 [getuserMe] Error: No data or empty data")
                return
            }
            
            // 응답 데이터를 문자열로 변환하여 출력
            if let dataString = String(data: JSONdata, encoding: .utf8) {
                print("Response Data String: \(dataString)")
            } else {
                print("🚨 Error: Unable to convert data to string")
            }
            
            let decoder = JSONDecoder()
            do {
                // JSON 데이터를 User 구조체로 디코딩
                let user = try decoder.decode(User.self, from: JSONdata)
                print("✅ Success: \(user)")

                // userRole에서 "ROLE_" 부분을 제거
                let roleWithoutPrefix = user.role.replacingOccurrences(of: "ROLE_", with: "")

                UserDefaults.standard.set(user.name, forKey: "userName")
                UserDefaults.standard.set(user.part, forKey: "userPart")
                UserDefaults.standard.set(roleWithoutPrefix, forKey: "userRole")
                UserDefaults.standard.set(user.generation, forKey: "userGeneration")
                UserDefaults.standard.setValue(user.totalBonus, forKey: "userTotalBonus")
                UserDefaults.standard.setValue(user.totalMinus, forKey: "userTotalMinus")
                UserDefaults.standard.setValue(user.pangoolPoint, forKey: "pangoolPoint")
            } catch {
                print("🚨 Decoding Error:", error)
            }
        }
        task.resume()
    }
}
