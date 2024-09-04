//
//  PardAppModel.swift
//  PARD
//
//  Created by 진세진 on 3/5/24.
//

import Foundation

// MARK: - User 데이터 관리
struct User: Codable {
    let part: String
    let name: String
    let role: String
    let generation: String
    let totalBonus: Int
    let totalMinus: Double
    let pangoolPoint: Float

    init(part: String, name: String, role: String, generation: String, totalBonus: Int, totalMinus: Double, pangoolPoint: Float) {
        self.part = part
        self.name = name
        self.role = role
        self.generation = generation
        self.totalBonus = totalBonus
        self.totalMinus = totalMinus
        self.pangoolPoint = pangoolPoint
    }
}

struct UserRank: Codable {
    let partRanking: Int
    let totalRanking: Int

    init(partRanking: Int, totalRanking: Int) {
        self.partRanking = partRanking
        self.totalRanking = totalRanking
    }
}

let userEmail = UserDefaults.standard.string(forKey: "userEmail") ?? "failed"
let userName = UserDefaults.standard.string(forKey: "userName") ?? "failed"
let userPart = UserDefaults.standard.string(forKey: "userPart") ?? "failed"
let userRole = UserDefaults.standard.string(forKey: "userRole") ?? "failed"
let userGeneration = UserDefaults.standard.string(forKey: "userGeneration") ?? "failed"
let totalBonus = UserDefaults.standard.integer(forKey: "userTotalBonus")
let totalMinus = UserDefaults.standard.double(forKey: "userTotalMinus")
let pangoolPoint = UserDefaults.standard.float(forKey: "pangoolPoint") 

// MARK: - rank 데이터 관리
struct Rank: Codable {
    let part: String
    let name: String
    
    init(part: String, name: String){
        self.part = part
        self.name = name
    }
}

class RankManager {
    static let shared = RankManager()
    private init() {}

    var rankList: [Rank] = []
}

// MARK: - reason 데이터 관리
struct ReasonPardnerShip: Codable {
    let reasonId: Int
    let point: Float
    let reason: String
    let detail: String
    let createAt: String
    let bonus: Bool
    
    init(reasonId: Int, point: Float, reason: String, detail: String, createAt: String, bonus: Bool) {
        self.reasonId = reasonId
        self.point = point
        self.reason = reason
        self.detail = detail
        self.createAt = createAt
        self.bonus = bonus
    }
}

class ReasonManager {
    static let shared = ReasonManager()
    private init() {}
    var reasonList: [ReasonPardnerShip] = []
    var reason: ReasonPardnerShip?

    func getReason(completion: @escaping ([ReasonPardnerShip]) -> Void) {
        guard let urlLink = URL(string: url + "/reason") else {
            print("🚨 잘못된 URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlLink) { data, response, error in
            if let error = error {
                print("🚨 에러:", error)
                return
            }
            
            guard let JSONdata = data, !JSONdata.isEmpty else {
                print("🚨 [getReason] 에러: 데이터가 없거나 빈 데이터")
                return
            }
            
            if let dataString = String(data: JSONdata, encoding: .utf8) {
                print("🌱 응답 데이터 문자열: \(dataString)")
            } else {
                print("🚨 데이터를 문자열로 변환할 수 없음")
            }
            
            let decoder = JSONDecoder()
            do {
                if let reason = try? decoder.decode(ReasonPardnerShip.self, from: JSONdata) {
                    print("✅ 성공: Reason")
                    DispatchQueue.main.async {
                        self.reason = reason
                        completion([reason])
                    }
                } else {
                    let reasonArray = try decoder.decode([ReasonPardnerShip].self, from: JSONdata)
                    print("✅ 성공: Reason")
                    DispatchQueue.main.async {
                        self.reasonList = reasonArray
                        completion(reasonArray)
                    }
                }
            } catch {
                print("🚨 디코딩 에러:", error)
            }
        }
        
        task.resume()
    }


}

// MARK: - total rank
struct TotalRank: Codable {
    let name: String
    let part: String
    let totalBonus: Int
    
    init(name: String, part: String, totalBonus: Int){
        self.name = name
        self.part = part
        self.totalBonus = totalBonus
    }
}

class TotalRankManager {
    static let shared = TotalRankManager()
    private init() {}

    var totalRankList: [TotalRank] = []
}
