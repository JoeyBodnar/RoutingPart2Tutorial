import Vapor
import HTTP

class V1: RouteCollection {
    func build(_ builder: RouteBuilder) throws {
        let v1 = builder.grouped("api", "v1")
        
        let posts = v1.grouped("posts")
        let postController = PostController()
        postController.addRoutes(to: posts)
        
    }
}


extension Droplet {
    func setupRoutes() throws {
        let v1 = V1()
        try collection(v1)
    }
}
