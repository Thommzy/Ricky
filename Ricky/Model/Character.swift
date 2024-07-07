//
//  Character.swift
//  Ricky
//
//  Created by Timothy Obeisun on 7/6/24.
//

import Foundation

struct Characters: Codable {
    let results: [Character]
}

// MARK: - Character
struct Character: Codable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let gender: String?
    let image: String?
    let episode: [String]?
}
