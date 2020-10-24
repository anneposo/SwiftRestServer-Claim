import Kitura

let router = Router()

let dbObj = Database.getInstance()

// port number your server will listen to, using object "router"
Kitura.addHTTPServer(onPort: 8020, with: router)
Kitura.run() // runs http server
