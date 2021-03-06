//
//  toss.swift
//  DutchApp
//
//  Created by Hongdonghyun on 2020/01/16.
//  Copyright © 2020 Team Dutch. All rights reserved.
//

import Foundation

struct SimpleToss {
    private let baseUrl = URL(string: "https://toss.im/transfer-web/linkgen-api/link")!
    private let apiKey = "8ba40e1bf635494b8234f7ab727a2b3f"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func POSTrequest(bank: String, account: String, amount: String, completion: @escaping (Toss) -> ()) {
        let requestData = TossRequest(apiKey: self.apiKey, bankName: bank, bankAccountNo: account, amount: amount)
        var request = URLRequest(url: baseUrl)
        guard let jsonData = try? encoder.encode(requestData) else { return }
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)

                if let data = data, let res = try? self.decoder.decode(Toss.self, from: data) {
                    print("123123123")
                    print(res)
                    completion(res)
                }
            } else {
                print(error ?? "Unknown error")
            }
        }

        task.resume()
    }
}
