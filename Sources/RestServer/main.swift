import Kitura
import Cocoa

let router = Router()

//router.all("/PersonService/add", middleware: BodyParser())

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
    response.send("The Person record was successfully inserted (via POST method).")
    next()
}
/*
router.get("/PersonService/getAll") {
    request, response, next in
    
    // returns all rows of data from database table
    let pList = PersonDAO().getAll()
    
    // JSON Serialization
    let jsonData : Data = try JSONEncoder().encode(pList)
    let jsonStr = String(data: jsonData, encoding: .utf8) // converts json Data to a string
    // sends/prints Person DB records as json format (outputs as array of JSON objects)
    response.send(jsonStr)
    
    // prints list of Person records
    //response.send("getAll service response data : \(pList.description)")
    next()
}

// gets parameters via URL
router.get("/PersonService/add") {
    request, response, next in   // closure syntax
    
    let fn = request.queryParameters["FirstName"]
    let ln = request.queryParameters["LastName"]
    
    // let n = ...
    // if n != nil, then do ...
    // checks if SSN has a value (not nil), then
    if let n = request.queryParameters["SSN"] {
        let pObj = Person(fn: fn, ln: ln, n: n)
        PersonDAO().addPerson(pObj: pObj)
        response.send("The Person record was successfully inserted")
    } else {
        
    }
    next()
}*/

// port number your server will listen to, using object "router"
Kitura.addHTTPServer(onPort: 8020, with: router)
Kitura.run() // runs http server
