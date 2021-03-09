//
//  Users.swift
//  GitUser
//
//  Created by Divyesh Vekariya on 09/03/21.
//

import Foundation

struct Users: Decodable {
    let login:String
    let avatar_url:String
    let id:Int
    let url:String
    
    let followers:Int?
    let following:Int?

}
