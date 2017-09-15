import Vapor
 import HTTP

extension Droplet {
    func setupRoutes() throws {
        // simple get request:
        get("hello") { request in
            return "Hello, Vaporists!"
        }
        
        // nested paths
        get("hi/how/are/you") { request in
            return "this path is /hi /how /are /you"
        }
        
        // All routes must return either:
          // response representable, response, or throw
        
        // example of returning response:
        get("foo") { request in
            return Response(redirect: "https://apple.com")
        }
        
        
        get("bar") { request in
            return Response(status: Status.forbidden)
        }
        
        // return response with JSON
        get("vapor") { request in
            return try Response(status: Status.accepted, json: JSON(node: ["hello": "world!"]))
        }
        
        // /post/1 /post/2 ?
        get("post", Int.parameter) { request in
            let parameter = try request.parameters.next(Int.self)
            return "You requested route /post/\(parameter)"
        }
        
        get("post", Int.parameter, "comments") { request in
            let parameter = try request.parameters.next(Int.self)
            return "You requested route /post/\(parameter)/comments"
        }
        
        get("heart", String.parameter) { request in
            let parameter = try request.parameters.next(String.self)
            return "You requested route /heart/\(parameter)"
        }
        
        get("anythingHere", "*") { request in
            // this route matches:
               // /anything/1
               // /anything/1/2/3
            return "this is a fallback route"
        }
        
        let v1 = grouped("v1")
        v1.get("users") { request in
            return "this route is /users/all"
        }
        v1.get("comments") { request in
            return "this route is /users/none"
        }
        
        
        
        
    }
}
