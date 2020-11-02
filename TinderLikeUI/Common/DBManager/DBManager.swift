//
//  DBManager.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/29/20.
//  Copyright © 2020 Milton. All rights reserved.
//
import SQLite3
import Foundation

// MARK: - Custom Enum of Type Error
enum SqliteError: Error {
    
    case invalidDirecotyUrl
    case openDBFailed
    case prepareFailed
    case stepFailed
    case bidndFailed
    case invalidBundleUrl
    case copyFailed
    case tableCreationFailed
    case insertSQLiteFailed
    case deleteFailed
    case updateFailed
    case readFailed
    case deleteAllFailed
}

// MARK: - Protocol for Data Provider
protocol DatabaseProvider {
    
    func insert(user: UserInfo) throws // create
    func delete(whereId pKey: Int) throws //Delete
    func update(user: UserInfo, whereId pKey: Int) throws //Update
    func read() throws -> [UserInfo] //Read
    func insertUsers(users: [UserInfo]) throws //insert array
    
    init(dbName: String)
    
    var dbPath: String { get }
    var dbName: String { get }
}

// MARK: - Data Base Handler class created
class DBManager: DatabaseProvider {
   
    var dbPath: String = ""
    var dbName: String
    var dbPointer: OpaquePointer?
    static let shared = DBManager()
    
    // MARK: - Construction(Init)
    internal required init(dbName: String = "StoredUserData.db") {
        self.dbName = dbName
    }
    
    // MARK: - Create Dadat Base IF Required
    private func createDBIfRequired() throws {
        //Get the docs directory
        guard let docDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { throw SqliteError.invalidDirecotyUrl }
        self.dbPath = docDirectory.appendingPathComponent(self.dbName).path
        do {
            try self.copyDBIfneeded(adDestination: self.dbPath)
        } catch let error as SqliteError {
            throw error
        }
    }
    
    // MARK: - Copy Data Base If Needed
    func copyDBIfneeded(adDestination destPath: String) throws {
        guard let bundleUrl = Bundle.main.resourceURL?.appendingPathComponent(self.dbName) else {
            throw SqliteError.invalidBundleUrl
        }
        if FileManager.default.fileExists(atPath: destPath) {
            print("Document File Already Exist")
            print(destPath)
        } else if FileManager.default.fileExists(atPath: bundleUrl.path) {
            do {
                print(destPath)
                try FileManager.default.copyItem(atPath: bundleUrl.path, toPath: destPath)
            } catch {
                throw SqliteError.copyFailed
            }
        }
    }
    
    // MARK: - Open DB Connection
    func openConnection() throws -> OpaquePointer? {
        //opquePointer is required to access the db or interact
        var opaquePointer: OpaquePointer? // It's Swift type for C pointer.
        if sqlite3_open(self.dbPath, &opaquePointer) == SQLITE_OK {
            print("Success Open Connection DB")
            return opaquePointer
            
        } else {
            print("Faild to open connection DB")
            throw SqliteError.openDBFailed
        }
    }
    
    // MARK: - Close DB Connection
    func closeConnection() {
        sqlite3_close(self.dbPointer)
    }
    
    // MARK: - Create DB Table If does not exist
    func createTableIfRequired() throws {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS "User" (
                 "First Name"    TEXT NOT NULL,
                 "Last Name"    TEXT NOT NULL,
                 "ImageUrl"    TEXT NOT NULL,
                 "Id" INTEGER NOT NULL UNIQUE,
                PRIMARY KEY("Id" AUTOINCREMENT)
             );
        """
        //1.
        let dbHandler = try self.prepareStatement(sql: createTableQuery)
        
        defer {
            //3.
            // Finalize deletes the compiled statement to avoid memory licked
            sqlite3_finalize(dbHandler)
        }
        //2.
        guard sqlite3_step(dbHandler) == SQLITE_DONE else {
            print("Table no Created\n**Throw error**")
            throw SqliteError.tableCreationFailed
        }
        print("Created table Success")
    }
    
    // MARK: - Prepare DB
    func prepareStatement(sql: String) throws -> OpaquePointer? {
        var localPointer: OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, sql, -1, &localPointer, nil) == SQLITE_OK {
            return localPointer
            
        } else {
            throw SqliteError.prepareFailed
        }
    }
    
    // MARK: - Destructor(deinit)
    deinit {
        sqlite3_close(self.dbPointer) //close DB conncection
    }
}

extension DBManager {
    
    func insertUsers(users: [UserInfo]) throws {
        for  user in users {
            try self.insert(user: user)
        }
    }
    
    func startDB() {
        try? self.createDBIfRequired()
        self.dbPointer = try? self.openConnection()
        try? createTableIfRequired()
    }
    
    // MARK: - Insert UserInfo Row into DB Table
    func insert(user: UserInfo) throws {
        //1
        let query = """
        INSERT INTO User (`First Name`, `Last Name`, ImageUrl)
        VALUES (?, ?, ?);
        """
        //2
        let statement = try self.prepareStatement(sql: query)
        defer {
            //last
            sqlite3_finalize(statement)
        }
        //3
        guard sqlite3_bind_text(statement, 1, (user.title as NSString).utf8String, -1, nil) == SQLITE_OK &&
        sqlite3_bind_text(statement, 2, (user.subtitle as NSString).utf8String, -1, nil) == SQLITE_OK &&
            sqlite3_bind_text(statement, 3, (user.imageUrl! as NSString).utf8String, -1, nil) == SQLITE_OK else {
            throw SqliteError.bidndFailed
        }
        //4
        guard sqlite3_step(statement) == SQLITE_DONE else {
            throw SqliteError.insertSQLiteFailed
        }
        print("Values written Successfully")
    }
    // MARK: - Delete All Rows in DB Table
    func deleteAll() throws {
        let query = "DELETE FROM User"
        let statement = try self.prepareStatement(sql: query)
        defer {
            sqlite3_finalize(statement)
        }
        guard sqlite3_step(statement) == SQLITE_DONE else {
            throw SqliteError.deleteAllFailed
        }
        print("All Value deleted Succeessfully")
    }
    
    // MARK: - Delete A Row By Id in Table
    func delete(whereId pKey: Int) throws {
        let query = "DELETE FROM User WHERE Id = \(pKey)"
        //1
        let statement = try self.prepareStatement(sql: query)
        defer {
            //3
            sqlite3_finalize(statement)
        }
        //2
        guard sqlite3_step(statement) == SQLITE_DONE else {
            throw SqliteError.deleteFailed
        }
        print("Value deleted Succeessfully")
    }
    // MARK: - Update Rows in Table
    func update(user: UserInfo, whereId pKey: Int) throws {
        //1
        let query = """
        UPDATE User
        SET `First Name` = '\(user.title)', `Last Name` = '\(user.subtitle)', `ImageUrl` = '\(String(describing: user.imageUrl))'
        WHERE Id = \(pKey)
        """
        //2
        let statement = try self.prepareStatement(sql: query)
        defer {
            //4
            sqlite3_finalize(statement)
        }
        //3
        guard sqlite3_step(statement) == SQLITE_DONE else {
            throw SqliteError.updateFailed
        }
        print("updated Value Succeessfully")
    }
    
    // MARK: - Read Al Rows From Table
    func read() throws -> [UserInfo] {
        let query = "SELECT * FROM User;"
        var statement = try self.prepareStatement(sql: query)
        guard sqlite3_prepare_v2(dbPointer, query, -1, &statement, nil) == SQLITE_OK else {
            print("SELECT statement could not be prepared")
            throw SqliteError.readFailed
        }
        var users = [UserInfo]()
        while sqlite3_step(statement) == SQLITE_ROW {
            let fname = String(describing: String(cString: sqlite3_column_text(statement, 0)))
            let lname = String(describing: String(cString: sqlite3_column_text(statement, 1)))
            let urlImage = String(describing: String(cString: sqlite3_column_text(statement, 2)))
            let pId = sqlite3_column_int(statement, 3)
            users.append(UserInfo(imageUrl: urlImage, title: fname, subtitle: lname, pId: Int(pId)))
        }
        print("read Data Successfully")
        return users
    }
}

//Add sqlite support to the contact demo app which we created
//Functionality ot the implemented
//Implement a db manager for SQLite which has all the CRUD operations and can perform operation like
/*
 Open Connection
 Close Connection
 Create Table If needed
 Copying DB if Needed
 Go through the SQLite blog and tutorials and
 try to
 */
/*
 Adding Student will add the students information in DB as well
 On next launch, you will fetch data from the db and display it on the list screen.
 On update, the data will get updated in db based on seme identifier or unique id
 On Delete the record will get deleted from the database and won't show up again
 - Provide an potion to dlete all the records from the upp
 */
