//
//  UserProfile.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 19/11/2024.
//
//

import Foundation

struct UserProfile: Identifiable {
    let id = UUID()
    let name: String
    let imageUrl: String
    let hoursLeft: Int
    let isOnline: Bool
    var isFavorite: Bool = false
}
