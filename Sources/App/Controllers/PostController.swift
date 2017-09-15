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
