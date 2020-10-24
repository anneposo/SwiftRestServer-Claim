import Kitura
import Cocoa

let router = Router()

router.all("/ClaimService/add", middleware: BodyParser())

let dbObj = Database.getInstance()

// gets DB record parameters via request message body
router.post("/ClaimService/add") {
    request, response, next in
    let body = request.body // gets string from http message body
    let jObj = body?.asJSON // convert json string to json object
    
    if let jDict = jObj as? [String:String] { // if jDict is not nil
        if let t = jDict["title"], let d = jDict["date"] {
            let i = UUID()
            let solve = false
            let cObj = Claim(i: i.uuidString, t: t, d: d, solve: solve)
            ClaimDAO().addClaim(cObj: cObj)
        }
    }
    response.send("The Claim record was successfully inserted via POST method.")
    next()
}

router.get("/ClaimService/getAll") {
    request, response, next in
    // returns all rows of data from database table
    let cList = ClaimDAO().getAll()
    
    // JSON Serialization
    let jsonData : Data = try JSONEncoder().encode(cList)
    let jsonStr = String(data: jsonData, encoding: .utf8)
    
    response.send(jsonStr)
    next()
}


// port number your server will listen to, using object "router"
Kitura.addHTTPServer(onPort: 8020, with: router)
Kitura.run() // runs http server
