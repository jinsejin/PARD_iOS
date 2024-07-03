//
//  APICaller.swift
//  PARD
//
//  Created by 김하람 on 7/3/24.
//

import UIKit

//let url = "https://we-pard.store/v1/"

struct PardResponse: Codable {
    let success: Bool
    let message: String
}

func getData() {
    if let urlLink = URL(string: url + "users") {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlLink) { data, response, error in
            if let error = error {
                print("🚨 Error:", error)
                return
            }
            if let JSONdata = data {
                // 응답 데이터를 문자열로 변환하여 출력
                if let dataString = String(data: JSONdata, encoding: .utf8) {
                    print("Response Data String: \(dataString)")
                }
                
                let decoder = JSONDecoder()
                do {
                    // JSON 데이터 디코딩을 시도하기 전에, 데이터가 JSON 형식인지 확인
                    let jsonObject = try JSONSerialization.jsonObject(with: JSONdata, options: [])
                    print("Valid JSON Object: \(jsonObject)")

                    // JSON 데이터가 맞으면 디코딩 시도
//                        let decodeData = try decoder.decode([Test].self, from: JSONdata)
                    // self.pardData = PardData(data: decodeData)
                    DispatchQueue.main.async {
                        // self.tableView.reloadData()
                    }
                    print("✅ Success")
                } catch {
                    print("🚨 Decoding Error:", error)
                }
            }
        }
        task.resume()
    }
}

func makePostRequest(with name: String, age: Int, part: String) {
    guard let url = URL(string: "\(url)") else {
        print("🚨 Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: AnyHashable] = [
        "name": name,
        "part": part,
        "age": age
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            print("🚨 Error: \(error?.localizedDescription ?? "Unknown error")")
            return
        }

        if let responseString = String(data: data, encoding: .utf8) {
            print("✅ success: \(responseString)")
            if responseString.contains("파드에 가입을 축하드립니다") {
                DispatchQueue.main.async {
//                    NotificationCenter.default.post(name: .addNotification, object: nil)
                    print("✅ notification 완료 in makePostRequest")
                }
            }
        } else {
            print("🚨 Error: Unable to convert data to string")
        }
    }
    task.resume()
}

// MARK: - Update _ 특정 데이터에 대한 값을 서버에 수정하는 함수
func makeUpdateRequest(with idName: String, name: String, age: Int, part: String, imgUrl: String) {
    guard let encodedName = idName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
        print("Encoding failed")
        return
    }
    
    let urlString = "\(url)/pard/\(encodedName)"
    
    guard let url = URL(string: urlString) else {
        print("🚨 Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: Any] = [
        "name": "string",
        "part": "string",
        "age": 0
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    
    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            print("🚨 \(error?.localizedDescription ?? "Unknown error")")
            return
        }
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("✅ success: \(response)")
            DispatchQueue.main.async {
                DispatchQueue.main.async {
//                    NotificationCenter.default.post(name: .addNotification, object: nil)
                }
            }
        } catch {
            print("🚨 ", error)
        }
    }
    task.resume()
}

func deleteRequest(id: Int) {
    let urlString = "\(url)/pard/\(id)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    
    guard let url = URL(string: urlString!) else {
        print("🚨 Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("🚨 Error: \(error.localizedDescription)")
            return
        }

        guard let data = data else {
            print("🚨 Error: No data received")
            return
        }

        // Handle plain text response
        if let responseString = String(data: data, encoding: .utf8) {
            print("✅ Delete success: \(responseString)")
//            NotificationCenter.default.post(name: .addNotification, object: nil)
        } else {
            print("🚨 Error: Unable to convert data to string")
        }
    }
    task.resume()
}


