//
//  User+CoreDataProperties.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 22.08.26.
//
//

public import Foundation
public import CoreData


public typealias UserCoreDataPropertiesSet = NSSet

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
