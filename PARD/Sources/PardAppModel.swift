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
let partRanking = UserDefaults.standard.integer(forKey: "partRanking")
let totalRanking = UserDefaults.standard.integer(forKey: "totalRanking")
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
    
    func fetchReasons(completion: @escaping ([ReasonPardnerShip]) -> Void) {
        getReason { reasons in
            self.reasonList = reasons
            completion(reasons)
        }
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
