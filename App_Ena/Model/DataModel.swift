//
//  DataModel.swift
//  App_Ena
//
//  Created by Jared Romero on 9/10/24.
//

import Foundation

// MARK: - Welcome
struct DataModel: Codable {
    let lessons: [Lesson]
}

// MARK: - Lesson
struct Lesson: Codable {
    let topic, description: String
    let games: [Game]
}

// MARK: - Game
struct Game: Codable {
    let type, description: String
    let questions: [Question]
}

// MARK: - Question
struct Question: Codable {
    let image: String?
    let options: [String]?
    let correctAnswer: String?
    let word: String?
    let images: [String]?

    enum CodingKeys: String, CodingKey {
        case image, options
        case correctAnswer = "correct_answer"
        case word, images
    }
}

