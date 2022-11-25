//
//  CreditManager.swift
//  MyCreditManager
//
//  Created by sei on 2022/11/22.
//

import Foundation

class CreditManager {
    private static let S: [String: Status] = [
        "0": Start(),
        "1": AddStudent(),
        "2": DeleteStudent(),
        "3": AddScore(),
        "4": DeleteScore(),
        "5": ShowAvg()
    ]
    
    private var status: Status = CreditManager.S["0"]!
    private var students = [Student]()
    
    func run() {
        while true{
            do {
                printInfo()
                let input = try getInput()
                try doWith(input)
            } catch {
                print(error.localizedDescription)
                switch error {
                case CMError.quitProgram:
                    return
                default:
                    setState(name: "0")
                }
            }
        }
    }
    
    private func setState(name: String) {
        self.status = CreditManager.S[name]!
    }
    
    private func printInfo() {
        print(status.getInfoMessage())
    }
    
    private func getInput() throws -> ParsedInput {
        let input = readLine(strippingNewline: true)
        let parsedInput = try status.parseInput(rawInput: input)
        return parsedInput
    }
    
    private func doWith(_ input: ParsedInput) throws {
        switch self.status.name {
        case "0":
            let status = (input as! ParsedZero).status
            if status == "X" {
                throw CMError.quitProgram
                
            }
            else if status == "t" {
                
            } else {
                if ["2", "4", "5"].contains(status) && students.isEmpty {
                    throw CMError.emptyStudents
                }
                setState(name: status)
                return
            }
        case "1": // addStudent
            let name = (input as! ParsedOne).name
            if isExists(studentName:name) {
                throw CMError.studentAleadyExists(name: name)
            } else {
                let student = Student(name: name)
                students.append(student)
            }
            // deleteStudent
        case "2":
            if students.isEmpty { throw CMError.emptyStudents }
            let name = (input as! ParsedOne).name
            if isExists(studentName:name) {
                students.removeAll { $0.name == name }
            } else {
                throw CMError.studentNotFound(name: name)
            }
            // addScore
        case "3":
            let name = (input as! ParsedThree).name
            guard let student = students.first(where: { $0.name == name }) else {
                throw CMError.studentNotFound(name: name)
            }
            let course = (input as! ParsedThree).course
            let scoreString = (input as! ParsedThree).score
            guard let score = Util.convertIntoDouble(scoreString) else {
                throw CMError.wrongInput
            }
            student.setScore(course: course, score: score)
            // deleteScore
        case "4":
            let name = (input as! ParsedTwo).name
            guard let student = students.first(where: { $0.name == name }) else {
                throw CMError.studentNotFound(name: name)
            }
            let course = (input as! ParsedTwo).course
            guard student.removeScore(course: course) != nil else {
                throw CMError.courseNotFound(name: name, course:course)
            }
            // showAvg
        case "5":
            let name = (input as! ParsedOne).name
            guard let student = students.first(where: { $0.name == name }) else {
                throw CMError.studentNotFound(name: name)
            }
            if student.hasNoCourse() {
                throw CMError.emptyCourse(name: name)
            }
            student.printScores()
        case "t":
            let parsedInput = (input as! ParsedTwo)
            print(parsedInput)
        default:
            return
        }
        if let resInfo = status.getResMessage(res: input) {
            print(resInfo)
        }
        setState(name: "0")
    }
    
    private func isExists(studentName name: String) -> Bool {
        return students.contains { $0.name == name }
    }
}


