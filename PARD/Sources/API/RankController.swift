//
//  RankController.swift
//  PARD
//
//  Created by 김하람 on 7/8/24.
//

import UIKit

enum RankTop3FetchError: Error {
    case invalidURL
    case requestFailed
    case noData
    case decodingError(Error)
}

func getRankTop3(completion: @escaping (Result<[Rank], RankTop3FetchError>) -> Void) {
    guard let url = URL(string: url + "/rank/top3?generation=\(userGeneration)") else {
        print("Invalid URL")
        completion(.failure(.invalidURL))
        return
    }

    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { data, response, error in
        if let error = error {
            print("🚨 Error:", error)
            completion(.failure(.requestFailed))
            return
        }

        guard let jsonData = data else {
            print("🚨 Error: No data received")
            completion(.failure(.noData))
            return
        }

        do {
            let decoder = JSONDecoder()
            let ranks = try decoder.decode([Rank].self, from: jsonData)
            print("✅ \(ranks)")
            completion(.success(ranks))
        } catch {
            print("🚨 Decoding Error:", error)
            completion(.failure(.decodingError(error)))
        }
    }
    task.resume()
}

func getRankMe(completion: @escaping (UserRank?) -> Void) {
    if let urlLink = URL(string: url + "/rank/me") {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlLink) { data, response, error in
            if let error = error {
                print("🚨 Error:", error)
                completion(nil)
                return
            }
            
            guard let JSONdata = data, !JSONdata.isEmpty else {
                print("🚨 [getuserMe] Error: No data or empty data")
                completion(nil)
                return
            }
            
            // 응답 데이터를 문자열로 변환하여 출력
            if let dataString = String(data: JSONdata, encoding: .utf8) {
                print("Response Data String: \(dataString)")
            } else {
                print("🚨 Error: Unable to convert data to string")
                completion(nil)
            }
            
            let decoder = JSONDecoder()
            do {
                let userRank = try decoder.decode(UserRank.self, from: JSONdata)
                print("✅ Success: \(userRank)")
                completion(userRank)
                // MARK: debuging을 위한 코드입니다.
//                print("---> \(userRank.partRanking)")
//                print("---> \(userRank.totalRanking)")
                
            } catch {
                print("🚨 Decoding Error:", error)
            }
        }
        task.resume()
    }
}

func getTotalRank() {
    if let urlLink = URL(string: url + "/rank/total") {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlLink) { data, response, error in
            if let error = error {
                print("🚨 Error:", error)
                return
            }
            guard let JSONdata = data, !JSONdata.isEmpty else {
                print("🚨 [getTotalRank] Error: No data or empty data")
                return
            }
            if let dataString = String(data: JSONdata, encoding: .utf8) {
                print("Response Data String: \(dataString)")
            } else {
                print("🚨 Error: Unable to convert data to string")
            }
            
            let decoder = JSONDecoder()
            do {
                let totalRankList = try decoder.decode([TotalRank].self, from: JSONdata)
                TotalRankManager.shared.totalRankList = totalRankList
                print("✅ Success: \(totalRankList)")
                
                // MARK: - Debugging code
//                for totalRank in totalRankList {
//                    print("---> \(totalRank.name)")
//                    print("---> \(totalRank.part)")
//                    print("---> \(totalRank.totalBonus)")
//                }
                
            } catch {
                print("🚨 Decoding Error:", error)
            }
        }
        task.resume()
    }
}

func getTotalRank(completion: @escaping (Bool) -> Void) {
    if let urlLink = URL(string: url + "/rank/total?generation=\(userGeneration)") {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlLink) { data, response, error in
            if let error = error {
                print("🚨 Error:", error)
                completion(false)
                return
            }
            guard let JSONdata = data, !JSONdata.isEmpty else {
                print("🚨 [getTotalRank] Error: No data or empty data")
                completion(false)
                return
            }
            if let dataString = String(data: JSONdata, encoding: .utf8) {
                print("Response Data String: \(dataString)")
            } else {
                print("🚨 Error: Unable to convert data to string")
            }
            
            let decoder = JSONDecoder()
            do {
                let totalRankList = try decoder.decode([TotalRank].self, from: JSONdata)
                TotalRankManager.shared.totalRankList = totalRankList
                print("✅ Success: \(totalRankList)")
                
                // MARK: - Debugging code
//                for totalRank in totalRankList {
//                    print("---> \(totalRank.name)")
//                    print("---> \(totalRank.part)")
//                    print("---> \(totalRank.totalBonus)")
//                }
                
                completion(true)
            } catch {
                print("🚨 Decoding Error:", error)
                completion(false)
            }
        }
        task.resume()
    } else {
        completion(false)
    }
}
