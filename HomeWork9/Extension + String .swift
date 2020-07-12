//
//  Extension + String .swift
//  HomeWork9
//
//  Created by Роман on 11.07.2020.
//  Copyright © 2020 destplay. All rights reserved.
//

import Foundation

extension String {
    func regex(pattern: String) -> [String]   {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))

            return results.compactMap {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")

            return []
        }
    }
}

extension Substring {
    func toDouble() -> Double? {
        
        return Double(self)
    }
}
