//
//  MessageModel.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 2024.11.25.
//

import Foundation

struct MessageModel: Identifiable {
    var id: UUID = UUID()
    var message: String
    var isBot: Bool
    var timestamp: Date = Date()
}
