//
//  Constant.swift
//  MyCreditManager
//
//  Created by sei on 2022/11/22.
//

let ScoreDict = ["A+": 4.5, "A": 4.0, "B+": 3.5, "B": 3.0, "C+": 2.5, "C": 2.0, "D+": 1.5, "D": 1.0, "F": 0.0]

struct Info {
    static let start = "원하는 기능을 입력해주세요.\n"
    static let methods = "1: 학생 추가, 2: 학생 삭제, 3: 성적 추가(변경), 4: 성적 삭제, 5: 평점 보기, X: 종료"
    static let typeStudentNameToInsert = "추가할 학생의 이름을 입력해주세요."
    static func addedStudent(name: String) -> String {
        return "\(name) 학생을 추가했습니다."
    }
    static let typeStudentNameToDelete = "삭제할 학생의 이름을 입력해주세요."
    static func deletedStudent(name: String) -> String {
        return "\(name) 학생을 삭제했습니다."
    }
    static let addScoreInfo1 = "성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.\n"
    static let addScoreInfo2 = "입력 예) Mickey Swift A+\n"
    static let addScoreInfo3 = "학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다."
    static func addedScore(name:String, course: String, score: String) -> String {
        return "\(name) 학생의 \(course) 과목이 \(score)로 추가(변경)되었습니다."
    }
    static let deleteScoreInfo1 = "성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n"
    static let deleteScoreInfo2 = "입력 예) Mickey Swift"
    static func deletedScore(name:String, course:String) -> String {
        return "\(name) 학생의 \(course) 과목의 성적이 삭제되었습니다."
    }
    
    static let typeStudentNameForAvg = "평점을 알고 싶은 학생의 이름을 입력해주세요."
    static let exitProgram = "프로그램을 종료합니다..."
}
