//
//  OpenAIResponse.swift
//  HandyChatGPT
//
//  Created by Trudy on 2023/04/28.
//

import Foundation

// Model for request
struct OpenAIResponse: Codable {
    var id: String?
    var object: String?
    var created: Int?
    var choices: [Choice]
    var usage: Usage?
}

struct Choice: Codable {
    var index: Int?
    var message: [String: String]
    var finish_reason: String?
}

struct Usage: Codable {
    var prompt_tokens: Int?
    var completion_tokens: Int?
    var total_tokens: Int?
}

// Custom Model
struct Message: Identifiable, Hashable, Codable {
    var id = UUID()
    var role: RoleType
    var content: String
}

enum RoleType: String, Codable {
    case system = "system"
    case user = "user"
    case assistant = "assistant"
}
