//
//  ScheduleController.swift
//  PARD
//
//  Created by 김하람 on 7/3/24.
//

import UIKit

func getSchedule(for viewController: CalendarViewController) {
    if let urlLink = URL(string: url + "/schedule") {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlLink) { data, response, error in
            if let error = error {
                print("🚨 Error:", error)
                return
            }
            if let JSONdata = data {
                // 응답 데이터를 문자열로 변환하여 출력
                if let dataString = String(data: JSONdata, encoding: .utf8) {
                    print("✅ Get Schedule Response Data String: \(dataString)")
                }
                
                let decoder = JSONDecoder()
                do {
                    // JSON 데이터를 ScheduleModel 배열로 디코딩
                    let schedules = try decoder.decode([ScheduleModel].self, from: JSONdata)
                    print("✅ Success: \(schedules)")
                    
                    // 스케줄을 배열에 저장
                    DispatchQueue.main.async {
                        viewController.schedules = schedules
                        viewController.updateEvents()
                    }
                } catch {
                    print("🚨 Decoding Error:", error)
                }
            }
        }
        task.resume()
    }
}
