//
//  Status.swift
//  MyCreditManager
//
//  Created by sei on 2022/11/22.
//

import Foundation


protocol Status {
    var name: String { get }
    func parseInput(rawInput:String?) throws -> ParsedInput
    func getInfoMessage() -> String
    func getResMessage(res: ParsedInput) -> String?
}


struct Start: Status {
    let name = "0"
    private let validInputs = (1...5).map { String($0) } + ["X"]
    
    func parseInput(rawInput: String?) throws -> ParsedInput {
        let input = try Util.checkInputIsNotEmpty(rawInput)
        guard validInputs.contains(input) else { throw CMError.wrongInput }
        return ParsedZero(status: input)
    }
    
    func getInfoMessage() -> String {
        return Info.start + Info.methods
    }
    
    func getResMessage(res: ParsedInput) -> String? {
        return nil
    }
    
}

struct AddStudent: Status {
    let name = "1"
    
    func parseInput(rawInput: String?) throws -> ParsedInput {
        return try InputParser.parseName(from: rawInput)
    }
    
    func getInfoMessage() -> String {
        return Info.typeStudentNameToInsert
    }
    
    func getResMessage(res: ParsedInput) -> String? {
        let res = res as! ParsedOne
        return Info.addedStudent(name: res.name)
    }
}

struct DeleteStudent: Status {
    let name = "2"
    
    func parseInput(rawInput: String?) throws -> ParsedInput {
        return try InputParser.parseName(from: rawInput)
    }
    
    func getInfoMessage() -> String {
        return Info.typeStudentNameToDelete
    }
    
    func getResMessage(res: ParsedInput) -> String? {
        let res = res as! ParsedOne
        return Info.deletedStudent(name: res.name)
    }
}

struct AddScore: Status {
    let name = "3"

    func parseInput(rawInput: String?) throws -> ParsedInput {
        return try InputParser.parseNameCourseScore(from: rawInput)
    }
    
    func getInfoMessage() -> String {
        return Info.addScoreInfo1 + Info.addScoreInfo2 + Info.addScoreInfo3
    }
    
    func getResMessage(res: ParsedInput) -> String? {
        let res = res as! ParsedThree
        return Info.addedScore(name: res.name, course: res.course, score: res.score)
    }
}


struct DeleteScore: Status {
    let name = "4"
    
    func parseInput(rawInput: String?) throws -> ParsedInput {
        return try InputParser.parseNameCourse(from: rawInput)
    }
    
    func getInfoMessage() -> String {
        return Info.deleteScoreInfo1 + Info.deleteScoreInfo2
    }
    
    func getResMessage(res: ParsedInput) -> String? {
        let res = res as! ParsedTwo
        return Info.deletedScore(name: res.name, course: res.course)
    }
}

struct ShowAvg: Status {
    let name = "5"
    
    func parseInput(rawInput: String?) throws -> ParsedInput {
        return try InputParser.parseName(from: rawInput)
    }
    
    func getInfoMessage() -> String {
        return Info.typeStudentNameForAvg
    }
    
    func getResMessage(res: ParsedInput) -> String? {
        return nil
    }
}
