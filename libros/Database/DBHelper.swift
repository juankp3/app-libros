//
//  DBHelper.swift
//  libros
//
//  Created by Juan Kuga Palomino on 11/04/22.
//

import Foundation
import SQLite3

class DBHelper {
    
    var db : OpaquePointer?
    
    init() {
        self.db = getDatabasePointer(databaseName: "librosBD4.db")
    }
    
    func getDatabasePointer(databaseName: String)-> OpaquePointer? {
        var databasePointer : OpaquePointer?
        let documentDatabasePath = FileManager.default.urls(for: .documentDirectory, in:
                .userDomainMask)[0].appendingPathComponent(databaseName).path
        
        if FileManager.default.fileExists(atPath: documentDatabasePath){
            print("Database Exists (already)")
        } else {
            guard let bundleDatabasePath = Bundle.main.resourceURL?.appendingPathComponent(databaseName).path else {
                print("Unwrapping Error: Bundle Database Path doesn´t exist")
                return nil
            }
            
            do {
                try FileManager.default.copyItem(atPath: bundleDatabasePath, toPath: documentDatabasePath)
                print("Database created (copied)")
            } catch {
                print("Error \(error.localizedDescription)")
                return nil
            }
        }
        
        if sqlite3_open(documentDatabasePath, &databasePointer) == SQLITE_OK {
            print("Sucessfully open database")
            print("Database path: \(documentDatabasePath)")
        } else {
            print("Could not open database")
        }
                
        return databasePointer
    }
    
     func readBooks() -> [Book] {
        var mainBooks = [Book]()
        var statement : OpaquePointer? = nil
        let query = "SELECT * FROM Libros";
        
         if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                
                let id = Int(sqlite3_column_int(statement, 0))
                let name = String(cString: sqlite3_column_text(statement, 1))
                let description = String(cString: sqlite3_column_text(statement, 2))
                let image = String(cString: sqlite3_column_text(statement, 3))
                let price = Double(sqlite3_column_double(statement, 4))
                let author = String(cString: sqlite3_column_text(statement, 5))
                let edition = String(cString: sqlite3_column_text(statement, 6))
                let category_id = Int(sqlite3_column_int(statement, 7))


                let m = Book()
                m.id = id
                m.name = name
                m.description = description
                m.image = image
                m.price = price
                m.author = author
                m.edition = edition
                m.category_id = category_id
                
                mainBooks.append(m)
                
            }
        }
        
        return mainBooks
    }
}
