//
//  ClaimDAO.swift
//  RestServer
//
//  Created by anneposo on 10/24/20.
//

struct Claim : Codable {
    // define properties then initialize values with initializer (init)
    var id : String?
    var title : String?
    var date : String
    var isSolved : String
    
    init(i: String?, t: String?, d: String, solve: String) {
        id = i
        title = t
        date = d
        isSolved = solve
    }
}
