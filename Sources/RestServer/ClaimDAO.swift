//
//  ClaimDAO.swift
//  RestServer
//
//  Created by anneposo on 10/24/20.
//

import SQLite3

struct Claim : Codable {
    // define properties then initialize values with initializer (init)
    var id : String
    var title : String?
    var date : String?
    var isSolved : Bool
    
    init(i: String, t: String?, d: String?, solve: Bool) {
        id = i
        title = t
        date = d
        isSolved = solve
    }
}


class ClaimDAO {
    // submits sql statement to database for adding record to table
    func addClaim(cObj : Claim) {
        let sqlStmt = String(format:"insert into claim (id, title, date, isSolved) values ('%@', '%@', '%@', '%@')", cObj.id, cObj.title!, cObj.date!, cObj.isSolved)
        
        // get database connection
        let conn = Database.getInstance().getDBConnection()
        
        // submits the insert sqlStmt and catches any errors trying to execute sqlStmt
        if sqlite3_exec(conn, sqlStmt, nil, nil, nil) != SQLITE_OK {
            let errcode = sqlite3_errcode(conn)
            print("Failed to insert a Person record due to error \(errcode)")
        }
        sqlite3_close(conn) // close db connection
    }
}
