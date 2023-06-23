//
//  DataStructure.swift
//  hw2Project
//
//  Created by Jack Liu on 6/22/23.
//

import Foundation

struct User: Codable, Identifiable, Hashable{
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
