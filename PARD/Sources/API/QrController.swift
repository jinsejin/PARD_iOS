//
//  QrController.swift
//  PARD
//
//  Created by 김하람 on 7/3/24.
//

import UIKit
extension ReaderViewController {
    func getValidQR(with qrUrl: String) {
        print("❤️ \(qrUrl)")
        guard let url = URL(string: "\(url)/validQR") else {
            print("🚨 Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: AnyHashable] = [
            "qrUrl": qrUrl,
            "seminar": "part"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("🚨 Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("✅ success: \(responseString)")
                if responseString.contains("잘못된") {
                    DispatchQueue.main.async {
                        ModalBuilder()
                            .add(title: "출석 체크")
                            .add(content: "유효하지 않은 QR 코드입니다.\n다시 시도해주세요.")
                            .add(button: .confirm(title: "확인", action: {
                            }))
                            .show(on: self)
                    }
                } else if responseString.contains("이미") {
                    DispatchQueue.main.async {
                        ModalBuilder()
                            .add(title: "출석 체크")
                            .add(image: "alreadyAttendance")
                            .add(button: .confirm(title: "세미나 입장하기", action: {
                            }))
                            .show(on: self)
                    }
                }
            } else {
                print("🚨 Error: Unable to convert data to string")
            }
        }
        task.resume()
    }
}
