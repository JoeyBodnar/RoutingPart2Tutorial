//
//  File.swift
//  routing
//
//  Created by Stephen Bodnar on 15/09/2017.
//
//

import Foundation
import Vapor
import FluentProvider

final class Post: Model {
    let storage = Storage()
    
    static let idKey = "id"
    static let titleKey = "title"
    static let uniqueIdKey = "uniqueIdKey"
    
    var title: String
    var uniqueId: String
    
    init(title: String, uniqueId: String) {
        self.title = title
        self.uniqueId = uniqueId
    }
    
    init(row: Row) throws {
        title = try row.get(Post.titleKey)
        uniqueId = try row.get(Post.uniqueIdKey)
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Post.titleKey, title)
        try row.set(Post.uniqueIdKey, uniqueId)
        return row
    }
}

extension Post: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(Post.titleKey)
            builder.string(Post.uniqueIdKey)
        }
    }
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension Post: JSONConvertible {
    convenience init(json: JSON) throws {
        try self.init(
            title: json.get(Post.titleKey),
            uniqueId: json.get(Post.uniqueIdKey)
        )
    }
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Post.idKey, id)
        try json.set(Post.titleKey, title)
        try json.set(Post.uniqueIdKey, uniqueId)
        return json
    }
}
