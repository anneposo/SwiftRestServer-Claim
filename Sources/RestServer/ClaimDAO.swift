//
//  ClaimDAO.swift
//  RestServer
//
//  Created by anneposo on 10/24/20.
//

import SQLite3
import Cocoa

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
        let sqlStmt = String(format:"insert into claim (id, title, date, isSolved) values ('%@', '%@', '%@', 0)", cObj.id, cObj.title!, cObj.date!)
        
        // get database connection
        let conn = Database.getInstance().getDBConnection()
        
        // submits the insert sqlStmt and catches any errors trying to execute sqlStmt
        if sqlite3_exec(conn, sqlStmt, nil, nil, nil) != SQLITE_OK {
            let errcode = sqlite3_errcode(conn)
            print("Failed to insert a Claim record due to error \(errcode)")
        }
        sqlite3_close(conn) // close db connection
    }
    
    func getAll() -> [Claim] { // returns list of Person objects
        var cList = [Claim]()
        var resultSet : OpaquePointer? // record returned from sqlStr query
        // sql query we will run, passed as an arg to sqlite3_prepare_v2()
        let sqlStr = "select id, title, date, isSolved from claim"
        let conn = Database.getInstance().getDBConnection()
        
        // 4th parameter is
        if sqlite3_prepare_v2(conn, sqlStr, -1, &resultSet, nil) == SQLITE_OK {
            // step through each record inside resultSet and exit if no more rows
            while(sqlite3_step(resultSet) == SQLITE_ROW) {
                let id_val = sqlite3_column_text(resultSet, 0)
                let id = String(cString: id_val!)
                let title_val = sqlite3_column_text(resultSet, 1)
                let title = String(cString: title_val!)
                let date_val = sqlite3_column_text(resultSet, 2)
                let date = String(cString: date_val!)
                let solve_val = sqlite3_column_int(resultSet, 3)
                let isSolved = Bool(solve_val as NSNumber)

                cList.append(Claim(i: id, t: title, d: date, solve: isSolved))
            }
        }
        return cList
    }
}
