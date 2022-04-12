//
//  Book.swift
//  libros
//
//  Created by Juan Kuga Palomino on 11/04/22.
//

import Foundation

class Book: Codable {
    var id : Int?
    var name : String?
    var description : String?
    var image : String?
    var price : Double?
    var author : String?
    var edition : String?
    var category_id : Int?
    
    init() {
      // initialize somehow with no input!
    }
}
