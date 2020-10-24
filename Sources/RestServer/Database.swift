//
//  Database.swift
//  RestServer
//
//  Created by anneposo on 10/23/20.
//

import SQLite3

class Database {
    
    static var dbObj : Database!
    let dbname = "/Users/anneposo/Desktop/CPSC-411/Homework1/ClaimDB.sqlite"
    var conn : OpaquePointer?
    
    init() {
        // 1. create database
        if sqlite3_open(dbname, &conn) == SQLITE_OK {
            // once db connection established, create tables
            initializeDB()
            sqlite3_close(conn) // close db connection
        } else {
            let errcode = sqlite3_errcode(conn)
            print("Open database failed due to error \(errcode)")
        }
    }
    
    private func initializeDB() {
        let sqlStmt = "create table if not exists claim (id text, title text, date text, isSolved int)"
        // catch + print any errors trying to execute the sqlstmt
        if sqlite3_exec(conn, sqlStmt, nil, nil, nil) != SQLITE_OK {
            let errcode = sqlite3_errcode(conn)
            print("Create table failed due to error \(errcode)")
        }
    }
    
    // opens database and returns db connection
    func getDBConnection() -> OpaquePointer? {
        var conn : OpaquePointer?
        if sqlite3_open(dbname, &conn) == SQLITE_OK {
            return conn
        } else {
            let errcode = sqlite3_errcode(conn)
            print("Open database failed due to error \(errcode)")
        }
        return conn
    }
    
    static func getInstance() -> Database { // returns a singleton database object
        if dbObj == nil { // if no db object created yet, then create one
            dbObj = Database()
        }
        return dbObj
    }
}
