//
//  PardAppModel.swift
//  PARD
//
//  Created by 진세진 on 3/5/24.
//

import Foundation

struct UserInfo {
    var name: String
    var part: String
    var score: String
}

struct PardAppModel {
    static var userInfos: [UserInfo] = [
        UserInfo(name: "이주형", part: "iOS파트", score: "20점"),
        UserInfo(name: "홍길동", part: "서버파트", score: "15점"),
        UserInfo(name: "민총무", part: "웹파트", score: "14점"),
        UserInfo(name: "박사무", part: "기획파트", score: "13점"),
        UserInfo(name: "나이름", part: "디자인파트", score: "12점"),
        UserInfo(name: "최지명", part: "iOS파트", score: "10점"),
        UserInfo(name: "이영희", part: "웹파트", score: "7점")
        
    ]
}

struct User: Codable {
    let part: String
    let name: String
    let role: String
    let generation: String
    
    init(part: String, name: String, role: String, generation: String) {
            self.part = part
            self.name = name
            self.role = role
            self.generation = generation
        }
}

let userName = UserDefaults.standard.string(forKey: "userName") ?? "failed"
let userPart = UserDefaults.standard.string(forKey: "userPart") ?? "failed"
let userRole = UserDefaults.standard.string(forKey: "userRole") ?? "failed"
let userGeneration = UserDefaults.standard.string(forKey: "userGeneration") ?? "failed"

