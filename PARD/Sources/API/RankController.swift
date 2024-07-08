//
//  RankController.swift
//  PARD
//
//  Created by 김하람 on 7/8/24.
//

import UIKit

import Foundation

func getRankTop3(completion: @escaping ([Rank]?) -> Void) {
    guard let url = URL(string: url + "/rank/top3") else {
        print("Invalid URL")
        completion(nil)
        return
    }

    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { data, response, error in
        if let error = error {
            print("🚨 Error:", error)
            completion(nil)
            return
        }

        guard let jsonData = data else {
            print("🚨 Error: No data received")
            completion(nil)
            return
        }

        do {
            let decoder = JSONDecoder()
            let ranks = try decoder.decode([Rank].self, from: jsonData)
            print("✅ \(ranks)")
            completion(ranks)
        } catch {
            print("🚨 Decoding Error:", error)
            completion(nil)
        }
    }
    task.resume()
}

func getRankMe() {
    if let urlLink = URL(string: url + "/rank/me") {
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
                let userRank = try decoder.decode(UserRank.self, from: JSONdata)
                print("✅ Success: \(userRank)")
                UserDefaults.standard.setValue(userRank.partRanking, forKey: "partRanking")
                UserDefaults.standard.setValue(userRank.totalRanking, forKey: "totalRanking")
                
                // MARK: - debuging을 위한 코드입니다.
                print("---> \(userRank.partRanking)")
                print("---> \(userRank.totalRanking)")
                
            } catch {
                print("🚨 Decoding Error:", error)
            }
        }
        task.resume()
    }
}
