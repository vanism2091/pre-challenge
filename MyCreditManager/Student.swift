//
//  Student.swift
//  MyCreditManager
//
//  Created by sei on 2022/11/22.
//

import Foundation

class Student {
    let name: String
    private var scores = [String: Double]()
    
    init(name: String) {
        self.name = name
    }
    
    func setScore(course: String, score: Double) {
        scores.updateValue(score, forKey: course)
    }
    
    func removeScore(course: String) -> Double? {
        return scores.removeValue(forKey: course)
    }
    
    func printScores() {
        for item in scores{
            print("\(item.key): \(item.value)")
        }
        print("평점: \(getAvg())")
    }
    
    func hasNoCourse() -> Bool {
        return scores.isEmpty
    }
    
    private func getAvg() -> String {
        let total = scores.values.reduce(0, +)
        return String(format: "%.2f", total/Double(scores.values.count))
    }
    
}
