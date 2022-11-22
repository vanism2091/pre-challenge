//
//  Output.swift
//  MyCreditManager
//
//  Created by sei on 2022/11/22.
//

import Foundation
import RegexBuilder

// MARK: -- String Extension

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

//MARK: -- Regex + Util

struct RegexString {
    fileprivate static let name = "^[A-Za-z]+$"
    fileprivate static let score = "^[A-D]{1}[+]?$|^F$|^[1-4]{1}(.5)?$|^0$"
}

struct Util {
    static func splitInput(_ input:String) -> [String] {
        let words = input.components(separatedBy: " ")
        return words
    }
    
    static func checkInputIsNotEmpty(_ input:String?) throws -> String {
        guard let input = input,
              input != "" else { throw CMError.wrongInput }
        return input
    }
    
    static func convertIntoDouble(_ score: String) -> Double? {
        if let score = Double(score) {
            return score
        }
        if let score = ScoreDict[score] {
            return score
        }
        return nil
    }
}

@available(macOS 13.0, *)
struct RM { // latest util
    fileprivate static let fieldSeperator = /\s{1}/
    fileprivate static let name = /^[A-Za-z]+$/
    fileprivate static let score = /^[A-D]{1}[+]?$|^F$|^[1-4]{1}(.5)?$|^0$/
//    fileprivate static let scoreString = /^[A-D]{1}[+]?$|^F$/
//    fileprivate static let scoreNumber = /^[1-4]{1}(.5)?$|^0$/
    
    fileprivate static let oneOutputMatcher = Regex {
        Capture { Self.name }
    }
    fileprivate static let twoOutputMatcher = Regex {
        Capture { OneOrMore { CharacterClass.any } }
        fieldSeperator
        Capture { OneOrMore { CharacterClass.any } }
    }
    fileprivate static let threeOutputMatcher = Regex {
        Capture { OneOrMore { CharacterClass.any } }
        fieldSeperator
        Capture { OneOrMore { CharacterClass.any } }
        fieldSeperator
        Capture { Self.score }
    }
}

//MARK: -- InputParser

struct InputParser {
    static func parseName(from rawInput: String?) throws -> ParsedInput {
        let input = try Util.checkInputIsNotEmpty(rawInput)
        if #available(macOS 13.0, *) {
            if let match = input.wholeMatch(of: RM.oneOutputMatcher) {
                return ParsedOne(name: String(match.1))
            }
        } else {
            if input.matches(RegexString.name) {
                return ParsedOne(name: input)
            }
        }
        throw CMError.wrongInput
    }
    
    static func parseNameCourse(from rawInput: String?) throws -> ParsedInput {
        let input = try Util.checkInputIsNotEmpty(rawInput)
        if #available(macOS 13.0, *) {
            if let match = input.wholeMatch(of: RM.twoOutputMatcher) {
                return ParsedTwo(
                    name: String(match.1),
                    course: String(match.2)
                )
            }
        } else {
            let words = Util.splitInput(input)
            if words.count == 2 &&
                !words.contains(where: {
                    !$0.matches(RegexString.name)
                    
                }) {
                return ParsedTwo(
                    name: words[0],
                    course: words[1]
                )
            }
        }
        throw CMError.wrongInput
    }
    
    static func parseNameCourseScore(from rawInput: String?) throws -> ParsedInput {
        let input = try Util.checkInputIsNotEmpty(rawInput)
        if #available(macOS 13.0, *) {
            if let match = input.wholeMatch(of: RM.threeOutputMatcher) {
                return ParsedThree(
                    name: String(match.1),
                    course: String(match.2),
                    score: String(match.3)
                )
            }
        } else {
            let words = Util.splitInput(input)
            if words.count == 3 &&
                words[0].matches(RegexString.name) &&
                words[1].matches(RegexString.name) &&
                words[2].matches(RegexString.score) {
                return ParsedThree(
                    name: words[0],
                    course: words[1],
                    score: words[2]
                )
            }
        }
        throw CMError.wrongInput
    }
}

//MARK: -- ParsedInput Structs

protocol ParsedInput { }

struct ParsedZero: ParsedInput {
    let status: String
}

struct ParsedOne: ParsedInput {
    let name: String
}

struct ParsedTwo: ParsedInput {
    let name: String
    let course: String
}

struct ParsedThree: ParsedInput {
    let name: String
    let course: String
    let score: String
}
