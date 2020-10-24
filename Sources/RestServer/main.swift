import Kitura

let router = Router()

//let dbObj = Database.getInstance()

router.post("/ClaimService/add") {
    request, response, next in
    let body = request.body // gets string from http message body
    let jObj = body?.asJSON // convert json string to json object
    
    if let jDict = jObj as? [String:String] { // if jDict is not nil
        if let i = jDict["id"], let t = jDict["title"], let d = jDict["date"], let solve = Int(jDict["isSolved"]!) {
            let cObj = Claim(i: i, t: t, d: d, solve: solve)
            ClaimDAO().addPerson(cObj: cObj)
        }
    }
    response.send("The Person record was successfully inserted (via POST method).")
    next()
}

// port number your server will listen to, using object "router"
Kitura.addHTTPServer(onPort: 8020, with: router)
Kitura.run() // runs http server
