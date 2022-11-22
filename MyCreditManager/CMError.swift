//
//  Error.swift
//  MyCreditManager
//
//  Created by sei on 2022/11/22.
//

import Foundation

public enum CMError: Error {
    case wrongInput
    case invalidStartInput
    case studentAleadyExists(name: String)
    case studentNotFound(name: String)
    case quitProgram
    case emptyStudents
    case emptyCourse(name: String)
    case courseNotFound(name: String, course:String)
}

extension CMError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .wrongInput:
            return "입력이 잘못되었습니다. 다시 확인해주세요."
        case .invalidStartInput:
            return "입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
        case let .studentAleadyExists(name):
            return "\(name): 이미 존재하는 학생입니다. 추가하지 않습니다."
        case let .studentNotFound(name):
            return "\(name) 학생을 찾지 못했습니다."
        case .quitProgram:
            return "프로그램을 종료합니다..."
        case .emptyStudents:
            return "등록된 학생이 존재하지 않습니다."
        case let .courseNotFound(name, course):
            return "\(name) - \(course): 등록되지 않은 과목입니다."
        case let .emptyCourse(name):
            return "\(name): 등록된 과목이 없습니다."
        }
    
    }
}
