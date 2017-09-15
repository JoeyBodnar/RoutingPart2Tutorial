//
//  PostController.swift
//  routing
//
//  Created by Stephen Bodnar on 15/09/2017.
//
//

import Foundation
import Vapor


final class PostController {
    
    func addRoutes(to routeBuilder: RouteBuilder) {
        routeBuilder.post("create", handler: create)
        routeBuilder.get("all", handler: all)
        routeBuilder.get(Post.parameter, handler: show)
    }
    
    func show(request: Request) throws -> ResponseRepresentable {
        let post = try request.parameters.next(Post.self)
        return post
    }
    
    func all(request: Request) throws -> ResponseRepresentable {
        return try Post.all().makeJSON()
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        guard let json = request.json else { throw Abort.badRequest }
        let post = try Post(json: json)
        try post.save()
        return post
    }
}
