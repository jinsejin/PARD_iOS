//
//  ReasonController.swift
//  PARD
//
//  Created by 김하람 on 7/3/24.
//

import UIKit

func getReason(completion: @escaping ([Reason]?) -> Void) {
    guard let urlLink = URL(string: url + "/reason") else {
        print("Invalid URL")
        completion(nil)
        return
    }

    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: urlLink) { data, response, error in
        if let error = error {
            print("🚨 Error:", error)
            completion(nil)
            return
        }
        guard let JSONdata = data, !JSONdata.isEmpty else {
            print("🚨 [getReason] Error: No data or empty data")
            completion(nil)
            return
        }

        let decoder = JSONDecoder()
        do {
            let reasons = try decoder.decode([Reason].self, from: JSONdata)
            print("✅ Success: Fetched Reasons - \(reasons)")
            completion(reasons)
        } catch {
            print("🚨 Decoding Error:", error)
            completion(nil)
        }
    }
    task.resume()
}
