//
//  FSTrackingDbMgt.swift
//  Flagship
//
//  Created by Adel Ferguen on 17/05/2023.
//  Copyright © 2023 FlagShip. All rights reserved.
//

import Foundation
import SQLite3


class FSTrackingDbMgt: FSQLiteWrapper {
    
    public init() {
        super.init(.DatabaseTracking)
    }

    // INSERT/CREATE operation prepared statement
    override func prepareInsertEntryStmt() -> Int32 {
        guard super.insertEntryStmt == nil else { return SQLITE_OK }
        let sql = "INSERT INTO table_hits (id, data_hit) VALUES (?,?)"
        // preparing the query
        let r = sqlite3_prepare(db_opaquePointer, sql, -1, &insertEntryStmt, nil)
        if r != SQLITE_OK {
            print("sqlite3_prepare insertEntryStmt")
        }
        return r
    }

    // DELETE operation prepared statement
    override func prepareDeleteEntryStmt() -> Int32 {
        guard deleteEntryStmt == nil else { return SQLITE_OK }
        let sql = "DELETE FROM table_hits WHERE id = ?"
        // preparing the query
        let r = sqlite3_prepare(db_opaquePointer, sql, -1, &deleteEntryStmt, nil)
        if r != SQLITE_OK {
            print("sqlite3_prepare deleteEntryStmt")
        }
        return r
    }

    // Read hits from database
    public func readTrackingFromDB() -> [String: [String: Any]] {
        var result: [String: [String: Any]] = [:]
        let queryStatementString = "SELECT * FROM table_hits;"
        if sqlite3_prepare_v2(db_opaquePointer, queryStatementString, -1, &readEntryStmt, nil) == SQLITE_OK {
            while sqlite3_step(readEntryStmt) == SQLITE_ROW {
                // Get the id for cacheHit
                if let id = sqlite3_column_text(readEntryStmt, 0) {
                    // Get the data of hit
                    if let dataRawColl = sqlite3_column_text(readEntryStmt, 1) {
                        // Convert the json string to dico
                        if let data = String(cString: dataRawColl).data(using: .utf8) {
                            do {
                                if let dico = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                                    result.updateValue(dico, forKey: String(cString: id))
                                }
                            } catch {
                                // Error on decode dataRawColl
                            }
                        }
                    }
                }
            }
            sqlite3_finalize(readEntryStmt)
        }
        return result
    }
}
