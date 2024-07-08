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
            completion(ranks)
        } catch {
            print("🚨 Decoding Error:", error)
            completion(nil)
        }
    }
    task.resume()
}
